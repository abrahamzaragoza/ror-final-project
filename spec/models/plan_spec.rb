require 'rails_helper'

RSpec.describe Plan, type: :model do
  let(:valid_plan) {
    Plan.new(
      plan_name: 'Test Plan',
      price_cents: 1000,
      price_currency: 'usd',
      plan_members: 10,
      plan_duration: 3
    )
  }

  it 'should save a valid plan' do
    expect(valid_plan.save).to be_truthy
  end

  it "it should not save a plan with an invalid name" do
    valid_plan.plan_name = 0
    expect(valid_plan.save).to be_falsy
    valid_plan.plan_name = nil
    expect(valid_plan.save).to be_falsy
    valid_plan.plan_name = 'ab'
    expect(valid_plan.save).to be_falsy
  end

  it "it should not save a plan with a cents lesser than 100" do
    valid_plan.price_cents = 0
    expect(valid_plan.save).to be_falsy
    valid_plan.price_cents = -1
    expect(valid_plan.save).to be_falsy
    valid_plan.price_cents = 99
    expect(valid_plan.save).to be_falsy
    valid_plan.price_cents = 'string'
    expect(valid_plan.save).to be_falsy
  end

  it "it should not save a plan with an invalid currency" do
    valid_plan.price_currency = ''
    expect(valid_plan.save).to be_falsy
    valid_plan.price_currency = nil
    expect(valid_plan.save).to be_falsy
  end

  it 'it should not save a plan with a members lesser than one' do
    valid_plan.plan_members = 0
    expect(valid_plan.save).to be_falsy
    valid_plan.plan_members = -1
    expect(valid_plan.save).to be_falsy
    valid_plan.plan_members = 'string'
    expect(valid_plan.save).to be_falsy
  end

  it "it should not save a plan with a duration lesser than one" do
    valid_plan.plan_duration = 0
    expect(valid_plan.save).to be_falsy
    valid_plan.plan_duration = -10
    expect(valid_plan.save).to be_falsy
  end
end
