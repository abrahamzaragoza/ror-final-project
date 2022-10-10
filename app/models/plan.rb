# frozen_string_literal: true

class Plan < ApplicationRecord
  validates :plan_name, presence: true, length: { minimum: 3 }
  validates :price_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100 }
  validates :price_currency, presence: true, length: { is: 3 }
  validates :plan_members, :plan_duration,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  monetize :price_cents

  has_one :user_plan, dependent: :destroy
end
