# frozen_string_literal: true

class CreateTaskHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :task_histories do |t|
      t.references :task, null: false, foreign_key: true
      t.string :list

      t.timestamps
    end
  end
end
