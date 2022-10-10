json.user do
  json.id @user.id
  json.first_name @user.first_name
  json.last_name @user.last_name
  json.email @user.email
  json.authorization_tier @user.authorization_tier
  json.manager_id @user.manager_id
  json.stripe_id @user.stripe_id
  json.free_trial_expired @user.free_trial_expired
  json.stripe_subscription_id @user.stripe_subscription_id

  if @user.stripe_subscription_id.present?

    json.user_plan do
      json.id @user_plan.id
      json.user_id @user_plan.user_id
      json.plan_id @user_plan.plan_id
      json.status @user_plan.status
      json.current_period_end @user_plan.current_period_end
      json.current_period_start @user_plan.current_period_start
      json.start_date @user_plan.start_date
      json.trial_end @user_plan.trial_end
      json.id @user_plan.id
      json.created_at @user_plan.created_at
      json.updated_at @user_plan.updated_at
    end
  end
end
