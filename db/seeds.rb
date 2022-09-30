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

boards = [
  {
    title: 'Main Board',
    visibility: 'private'
  },
  {
    title: 'Secondary Board',
    visibility: 'public'
  }
]

task_lists = [
  {
    name: 'Dev',
    color: '#46dd4e',
    priority: 'low'
  },
  {
    name: 'Prod',
    color: '#be7eff',
    priority: 'critical'
  },
  {
    name: 'Testing',
    color: '#ff6f59',
    priority: 'important'
  }
]

tasks = [
  {
    title: 'Prepare feature A',
    started_at: Time.zone.now,
    finished_at: Time.zone.now,
    doing_time: 3,
    justification: 'Some justification for this task',
    details: '<p>Something nice</p>'
  },
  {
    title: 'Fix feature B',
    started_at: Time.zone.now,
    finished_at: Time.zone.now,
    doing_time: 4,
    justification: 'Fixing this features requires a decent amount of time',
    details: '<p>Something nice</p>'
  },
  {
    title: 'Create feature C',
    started_at: Time.zone.now,
    finished_at: Time.zone.now,
    doing_time: 2,
    justification: 'This feature is simple to implement',
    details: '<p>Something nice</p>'
  },
  {
    title: 'Add new feature',
    started_at: Time.zone.now,
    finished_at: Time.zone.now,
    doing_time: 5,
    justification: 'Sample task justification',
    details: '<p>Something nice</p>'
  },
  {
    title: 'Update feature A',
    started_at: Time.zone.now,
    finished_at: Time.zone.now,
    doing_time: 4,
    justification: 'Adding new complex options to feature A',
    details: '<p>Something nice</p>'
  }
]

boards.each do |b|
  Board.create!(
    title: b[:title],
    visibility: b[:visibility]
  )
end

Rails.logger.debug 'Boards have been created'

Board.all.each do |b|
  task_lists.each do |tl|
    TaskList.create!(
      name: tl[:name],
      color: tl[:color],
      priority: tl[:priority],
      board_id: b.id
    )
  end
end

Rails.logger.debug 'Task Lists have been created'

TaskList.all.each do |tl|
  tasks.each do |task|
    Task.create!(
      title: task[:title],
      started_at: task[:started_at],
      finished_at: task[:finished_at],
      doing_time: task[:doing_time],
      justification: task[:justification],
      details: task[:details],
      task_list_id: tl.id
    )
  end
end

Rails.logger.debug 'Tasks have been created'
