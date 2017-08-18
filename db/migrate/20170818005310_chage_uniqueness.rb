class ChageUniqueness < ActiveRecord::Migration[5.0]
  def change
  	add_index :users, [:email, :provider], unique: true
  end
end
