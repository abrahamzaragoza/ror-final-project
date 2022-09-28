# frozen_string_literal: true

class Board < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 80 }
  enum visibility: { public: 0, private: 1 }, _prefix: :visibility

  has_many :task_lists, dependent: :destroy
  after_destroy :destroy_linked_task_lists

  private

  def destroy_linked_task_lists
    task_lists.all.each do |list|
      list.destroy
    end
  end
end
