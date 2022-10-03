# frozen_string_literal: true

class AddTaskListReferenceToTask < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :task_list, null: false, foreign_key: true
  end
end
