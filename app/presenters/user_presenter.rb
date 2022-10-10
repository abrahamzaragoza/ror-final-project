# frozen_string_literal: true

# this is an example of a complex, well done presenter
# remember to add spaces
# although it would be very easy, the singleton 
# design pattern would have very useful to replace
# the use of many declarations of the strftime method attributes
# https://levelup.gitconnected.com/alternatives-to-global-variables-34982becfcc 
class UserPresenter
  def initialize(user)
    @user = user
    # example of space
    if @user.stripe_subscription_id.present?
      @user_plan = UserPlan.find(@user.plan.id)
      @plan = Plan.find(@user_plan.plan_id)
    end
  end

  def security_update_status
    {
      true => 'suscribed',
      false => 'unsuscribed'
    }[@user.security_updates]
  end

  def security_update_color
    {
      true => 'green',
      false => 'red'
    }[@user.security_updates]
  end

  def subscribed_plan_name
    @plan.plan_name
  end

  def suscribed_plan_status
    @user_plan.status.upcase
  end

  def suscribed_plan_status_color
    {
      'incomplete' => '255,193,7',
      'incomplete_expired' => '108,117,125',
      'trialing' => '25,135,84',
      'active' => 'success',
      'past_due' => '220,53,69',
      'canceled' => '220,53,69',
      'unpaid' => '220,53,69' }[@user_plan.status]
  end

  # you already had
  def suscribed_plan_nex_payday
    Time.at(@user_plan.start_date).strftime('%m/%d/%Y')
  end

  def subscribed_trial_end_date
    Time.at(@user_plan.trial_end).strftime('%m/%d/%Y')
  end

  def subscribed_trial_info
    end_date = subscribed_trial_end_date
    if @user.free_trial_expired
      'Your free trial period has expired'
    else
      "Your free trial period is currenly active and will end <strong>#{end_date}</strong>".html_safe
    end
  end

  def user_has_subscription?
    @user.stripe_subscription_id.present?
  end
end
