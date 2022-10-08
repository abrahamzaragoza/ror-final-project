# frozen_string_literal: true

class AddPriceIdToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :stripe_price_id, :string
    add_column :users, :stripe_subscription_id, :string
  end
end
