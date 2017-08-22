class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :price
      t.string :link
      t.string :pic_link
      t.string :shop_name

      t.timestamps
    end
  end
end
