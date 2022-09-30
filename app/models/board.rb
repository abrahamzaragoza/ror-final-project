# frozen_string_literal: true

class Board < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 80 }
  enum visibility: { public: 0, private: 1 }, _prefix: :visibility

  has_many :task_lists, dependent: :destroy
end
