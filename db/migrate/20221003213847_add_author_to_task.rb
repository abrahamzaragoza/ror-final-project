class AddAuthorToTask < ActiveRecord::Migration[6.1]
  def change
    change_table :tasks do |t|
      t.references :author, index: true, foreign_key: { to_table: :users }
    end
  end
end
