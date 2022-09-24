# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plan, type: :model do
  let(:valid_plan) do
    described_class.new(
      plan_name: 'Test Plan',
      price_cents: 1000,
      price_currency: 'usd',
      plan_members: 10,
      plan_duration: 3
    )
  end

  let(:count) { described_class.all.count }

  context 'with & without right params, create plan' do
    it 'saves & increment the Plan count' do
      expect { valid_plan.save }.to change { described_class.all.count }.by(1)
    end

    it 'does not save a plan with an invalid name | not string' do
      valid_plan.plan_name = 0
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with an invalid name | nil' do
      valid_plan.plan_name = nil
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with an invalid name | length < 3' do
      valid_plan.plan_name = 'ab'
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with a negative cents' do
      valid_plan.price_cents = -1
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with a cents lesser than 100' do
      valid_plan.price_cents = 99
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with cents as string' do
      valid_plan.price_cents = 'string'
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with blank currency' do
      valid_plan.price_currency = ''
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with nil currency' do
      valid_plan.price_currency = nil
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with a members lesser than one' do
      valid_plan.plan_members = 0
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with a zero as duration' do
      valid_plan.plan_duration = 0
      expect(valid_plan.save).to be_falsy
    end

    it 'does not save a plan with a negative duration' do
      valid_plan.plan_duration = -10
      expect(valid_plan.save).to be_falsy
    end
  end

  context 'with previusly saved plan, update Plan Tests' do
    before do
      valid_plan.save
    end

    let(:plan) { described_class.first }

    it 'updates the plan with valid params' do
      expect(plan.update(price_currency: 'mxn')).to be_truthy
    end

    it "updates the plan's name" do
      plan.update(plan_name: 'Test Plan Updated')
      expect(plan.plan_name).to eq 'Test Plan Updated'
    end

    it "does not update the plan's name with wrong params" do
      plan.update(plan_name: nil)
      expect(plan.plan_name).to be_falsy
    end
  end

  context 'with previusly saved plan, destroy plan' do
    before do
      valid_plan.save
    end

    it 'decreases the Plan count' do
      expect { described_class.delete(valid_plan) }.to change { described_class.all.count }.by(-1)
    end
  end
end
