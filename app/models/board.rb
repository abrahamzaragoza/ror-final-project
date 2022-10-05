# frozen_string_literal: true

class Board < ApplicationRecord
  MAX_LIST = 50

  validates :title, presence: true, length: { minimum: 3, maximum: 80 }
  enum visibility: { public: 0, private: 1 }, _prefix: :visibility

  has_many :task_lists, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  def able_to_create_list?
    task_lists.count < MAX_LIST
  end
end
