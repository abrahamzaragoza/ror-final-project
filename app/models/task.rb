# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, :doing_time, :justification, presence: true
  validates :doing_time, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  has_rich_text :details
  belongs_to :task_list
end
