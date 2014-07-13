class CreateHotelsNews < ActiveRecord::Migration
  def change
    create_table :hotels_news do |t|
      t.string :title
      t.integer :star_rating
      t.boolean :breakfast
      t.text :description
      t.string :photo
      t.decimal :price
      t.integer :address
      t.integer :user_id

      t.timestamps
    end
    add_index :hotels_news, [:user_id, :created_at]
  end
end
