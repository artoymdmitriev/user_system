class AddNullableValues < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :created_at, :datetime, :null => true
  end
end
