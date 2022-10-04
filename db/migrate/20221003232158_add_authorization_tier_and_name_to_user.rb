class AddAuthorizationTierAndNameToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :authorization_tier, default: 'user'
      t.string :first_name
      t.string :last_name
    end
  end
end
