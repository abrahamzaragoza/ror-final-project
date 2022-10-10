# frozen_string_literal: true

class AddStripeProductIdToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :stripe_product_id, :string
  end
end
