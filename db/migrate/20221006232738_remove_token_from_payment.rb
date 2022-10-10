# frozen_string_literal: true

class RemoveTokenFromPayment < ActiveRecord::Migration[6.1]
  def up
    remove_column :payments, :token
  end

  def down
    add_columnd :payments, :token
  end
end
