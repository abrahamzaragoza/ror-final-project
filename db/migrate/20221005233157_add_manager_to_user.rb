# frozen_string_literal: true

class AddManagerToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.references :manager, foreign_key: { to_table: :users }
    end
  end
end
