class ChangeIsBlockedDefaultValue < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :is_blocked, :boolean, default: false
  end
end
