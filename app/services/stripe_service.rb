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

  def create_charge(plan, user)
    stripe_customer = find_or_create_customer(user)
    Stripe::Charge.create({ amount: plan.price_cents, currency: plan.price_currency,
                            source: stripe_customer.default_source,
                            customer: stripe_customer.id,
                            description: "Charge by TeamTask - #{plan.plan_name} for $#{plan.price}" })
  end

  def find_or_create_product(plan)
    if plan.stripe_product_id.present?
      stripe_product = Stripe::Product.retrieve(plan.stripe_product_id)
    else
      stripe_product = Stripe::Product.create({ description: "#{plan.plan_name} for up to #{plan.plan_members} members",
                                                name: plan.plan_name,
                                                default_price_data: { currency: plan.price_currency,
                                                                      unit_amount: plan.price_cents,
                                                                      recurring: { interval_count: plan.plan_duration,
                                                                                    interval: 'month' } } })
      plan.update(stripe_product_id: stripe_product.id)
    end
    stripe_product
  end

  def create_subscription(user, plan)
    stripe_plan = Stripe::Subscription.retrieve(plan.stripe_product_id)
    Stripe::Subscription.create({ customer: user.stripe_id,
                                  items: [{ price: stripe_plan.default_price }],
                                  trial_end: Time.now.to_i + 15.days })
  end
end
