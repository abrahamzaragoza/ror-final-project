# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :token
      t.string :card_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
