class Plan < ApplicationRecord
  validates :plan_name, presence: true, length: { minimum: 3 }
  validates :price_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price_currency, presence: true
  validates :plan_members, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :plan_duration, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  monetize :price_cents
end
