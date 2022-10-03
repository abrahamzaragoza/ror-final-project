# frozen_string_literal: true

class AddOwnerToBoard < ActiveRecord::Migration[6.1]
  def change
    change_table :boards do |t|
      t.references :owner, index: true, foreign_key: { to_table: :users }
    end
  end
end
