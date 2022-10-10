# frozen_string_literal: true

require 'stripe'

class StripeService
  def initialize
    Stripe.api_key = Rails.application.credentials.stripe[:secret_test_key]
  end

  def find_or_create_customer(user)
    if user.stripe_id.present?
      stripe_customer = Stripe::Customer.retrieve(user.stripe_id)
    else
      stripe_customer = Stripe::Customer.create({ name: user.full_name, email: user.email })
      user.update(stripe_id: stripe_customer.id)
    end
    stripe_customer
  end

  def create_card_token(params)
    payment = params[:payment]
    Stripe::Token.create({ card: { number: payment[:card_number], exp_month: payment[:card_expires_month],
                                   exp_year: payment[:card_expires_year], cvc: payment[:card_cvv] } })
  end

  def create_stripe_card(params, user)
    token = create_card_token(params)
    Stripe::Customer.create_source(user.stripe_id, { source: token.id })
  end

  def create_product(plan)
    Stripe::Product.create({  description: "#{plan.plan_name} for up to #{plan.plan_members} members",
                              name: plan.plan_name,
                              default_price_data: { currency: plan.price_currency,
                                                    unit_amount: plan.price_cents,
                                                    recurring: {  interval_count: plan.plan_duration,
                                                                  interval: 'month' } } })
  end

  def find_or_create_product(plan)
    if plan.stripe_product_id.present?
      stripe_product = Stripe::Product.retrieve(plan.stripe_product_id)
    else
      stripe_product = create_product(plan)
      plan.update(stripe_product_id: stripe_product.id, stripe_price_id: stripe_product.default_price)
    end
    stripe_product
  end

  def create_subscription(user, plan)
    subscription = if user.free_trial_expired
                     Stripe::Subscription.create({  customer: user.stripe_id,
                                                    items: [{ price: plan.stripe_price_id }] })
                   else
                     Stripe::Subscription.create({  customer: user.stripe_id,
                                                    items: [{ price: plan.stripe_price_id }],
                                                    trial_end: Time.now.to_i + 15.days })
                   end
    user.update(stripe_subscription_id: subscription.id)
  end

  def cancel_subscription(user)
    Stripe::Subscription.delete(user.stripe_subscription_id)
    user.update(stripe_subscription_id: nil)
  end
end
