# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
