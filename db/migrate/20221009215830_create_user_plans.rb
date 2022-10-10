# frozen_string_literal: true

class CreateUserPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :user_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true, type: :uuid
      t.integer :status
      t.integer :current_period_end
      t.integer :current_period_start
      t.integer :start_date
      t.integer :trial_end

      t.timestamps
    end
  end
end
