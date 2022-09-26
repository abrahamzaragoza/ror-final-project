class Task < ApplicationRecord
  validates :title, :doing_time, :justification, presence: true

  has_rich_text :details
end
