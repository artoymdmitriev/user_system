class MakeFieldsNullable < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :email, :string, :null => true
  	change_column :users, :encrypted_password, :string, :null => true
  	change_column :users, :sign_in_count, :integer, :null => true
  	change_column :users, :created_at, :datetime, :null => true
  	change_column :users, :updated_at, :datetime, :null => true
  end
end
