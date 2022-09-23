class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans, id: :uuid do |t|
      t.string :plan_name
      t.monetize :price
      t.integer :plan_members
      t.integer :plan_duration

      t.timestamps
    end
  end
end
