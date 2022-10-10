# frozen_string_literal: true

class AddTrialExpiredToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :free_trial_expired, :boolean, default: false
  end
end
