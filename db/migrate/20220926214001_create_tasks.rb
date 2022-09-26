class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :doing_time
      t.string :justification

      t.timestamps
    end
  end
end
