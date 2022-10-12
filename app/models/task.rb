# frozen_string_literal: true

class Task < ApplicationRecord
  # same for this model DSL methods
  validates :title, :doing_time, :justification, presence: true
  validates :doing_time, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  has_rich_text :details
  belongs_to :task_list
  belongs_to :author, class_name: 'User'
  has_many :task_histories, dependent: :destroy
  has_many :task_users, dependent: :destroy
  has_many :users, through: :task_users

  alias_attribute :assigned_users, :users

  after_create :add_task_history_record_on_create
  before_update :add_task_history_record_on_update

  accepts_nested_attributes_for :task_users

  def add_task_history_record_on_create
    TaskHistory.create(task: self, list: task_list.name)
  end

  def add_task_history_record_on_update
    TaskHistory.create(task: self, list: task_list.name) unless task_list_id == task_list_id_was
  end

  def not_assignated_users
    user_ids = task_users.pluck(:user_id)
    User.where(manager_id: author).where.not(id: user_ids)
  end
end
