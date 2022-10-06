# frozen_string_literal: true

class AddSecurityUpdatesToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :security_updates, :boolean, default: true
  end
end
