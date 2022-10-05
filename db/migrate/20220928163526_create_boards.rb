# frozen_string_literal: true

class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.string :title
      t.integer :visibility

      t.timestamps
    end
  end
end
