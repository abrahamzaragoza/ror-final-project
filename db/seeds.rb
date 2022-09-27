# frozen_string_literal: true

plans = [
  {
    plan_name: 'Basic Plan',
    price_cents: 10_00,
    price_currency: 'usd',
    plan_members: 5,
    plan_duration: 1
  },
  {
    plan_name: 'Intermediate Plan',
    price_cents: 35_00,
    price_currency: 'usd',
    plan_members: 10,
    plan_duration: 3
  },
  {
    plan_name: 'Premium Plan',
    price_cents: 100_00,
    price_currency: 'usd',
    plan_members: 25,
    plan_duration: 6
  }
]

plans.each do |plan_mock|
  Plan.create!(
    plan_name: plan_mock[:plan_name],
    price_cents: plan_mock[:price_cents],
    price_currency: plan_mock[:price_currency],
    plan_members: plan_mock[:plan_members],
    plan_duration: plan_mock[:plan_duration]
  )
end

Rails.logger.debug 'Plans have been created'

tasks = [
  {
    title: 'Prepare feature A',
    started_at: Time.now,
    finished_at: Time.now,
    doing_time: 3,
    justification: 'Some justification for this task'
  },
  {
    title: 'Fix feature B',
    started_at: Time.now,
    finished_at: Time.now,
    doing_time: 4,
    justification: 'Fixing this features requires a decent amount of time'
  },
  {
    title: 'Create feature C',
    started_at: Time.now,
    finished_at: Time.now,
    doing_time: 2,
    justification: 'This feature is simple to implement'
  },
  {
    title: 'Add new feature',
    started_at: Time.now,
    finished_at: Time.now,
    doing_time: 5,
    justification: 'Sample task justification'
  },
  {
    title: 'Update feature A',
    started_at: Time.now,
    finished_at: Time.now,
    doing_time: 4,
    justification: 'Adding new complex options to feature A'
  }
]

tasks.each do |task|
  Task.create!(
    title: task[:title],
    started_at: task[:started_at],
    finished_at: task[:finished_at],
    doing_time: task[:doing_time],
    justification: task[:justification]
  )
end

Rails.logger.debug 'Tasks have been created'
