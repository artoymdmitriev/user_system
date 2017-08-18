class ChageUniqueness < ActiveRecord::Migration[5.0]
  def change
  	add_index :users, [:email, :provider], unique: true
  	remove_index(:users, :name => 'index_users_on_email')
  end
end
