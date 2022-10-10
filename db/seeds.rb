# frozen_string_literal: true

admin = User.new(
  {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    authorization_tier: 'admin',
    email: Faker::Internet.email,
    password: 'password'
  }
)
admin.skip_confirmation!
admin.save!

manager = User.new(
  {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    authorization_tier: 'manager',
    email: Faker::Internet.email,
    password: 'password'
  }
)
manager.skip_confirmation!
manager.save!

4.times do
  user = User.new(
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      authorization_tier: 'user',
      email: Faker::Internet.email,
      password: 'password',
      invited_by_id: manager.id,
      manager_id: manager.id
    }
  )
  user.skip_confirmation!
  user.save!
end

Rails.logger.debug 'Users have been created'

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

# on seeds there is no need to call the logger itself
# puts write into the debug logger. 
Rails.logger.debug 'Plans have been created'

boards = [
  {
    title: Faker::Lorem.word,
    visibility: 'private'
  },
  {
    title: Faker::Lorem.word,
    visibility: 'public'
  }
]

task_lists = [
  {
    name: Faker::Lorem.sentence(word_count: 3),
    color: Faker::Color.hex_color,
    priority: 'low'
  },
  {
    name: Faker::Lorem.sentence(word_count: 3),
    color: Faker::Color.hex_color,
    priority: 'critical'
  },
  {
    name: Faker::Lorem.sentence(word_count: 3),
    color: Faker::Color.hex_color,
    priority: 'important'
  }
]

task = {
  title: Faker::Lorem.sentence(word_count: 3),
  started_at: Time.zone.now,
  finished_at: Time.zone.now,
  doing_time: Faker::Number.number(digits: 1),
  justification: Faker::Lorem.sentence(word_count: 4),
  details: "<p>#{Faker::Markdown.headers}</p>"
}

boards.each do |b|
  Board.create!(
    title: b[:title],
    visibility: b[:visibility],
    owner_id: manager.id
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
  6.times do
    Task.create!(
      title: task[:title],
      started_at: task[:started_at],
      finished_at: task[:finished_at],
      doing_time: task[:doing_time],
      justification: task[:justification],
      details: task[:details],
      task_list_id: tl.id,
      author_id: manager.id
    )
  end
end

Rails.logger.debug 'Tasks have been created'
