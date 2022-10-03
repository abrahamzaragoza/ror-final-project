# frozen_string_literal: true

class CreateTaskLists < ActiveRecord::Migration[6.1]
  def change
    create_table :task_lists do |t|
      t.string :name
      t.string :color
      t.integer :priority
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
