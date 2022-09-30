# frozen_string_literal: true

class TaskList < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :color, presence: true, format: { with: /\A#[a-zA-Z0-9]*/, message: 'Only hexadecimal values allowed' },
                    length: { minimum: 4, maximum: 7 }
  enum priority: { low: 0, normal: 1, important: 2, critical: 3 }, _suffix: :priotity

  belongs_to :board
  has_many :tasks, dependent: :destroy
end
