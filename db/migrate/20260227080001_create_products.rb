class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock_count, default: 0, null: false
      t.references :category, null: false, foreign_key: true
      t.string :slug
      t.boolean :featured, default: false
      t.string :image_url

      t.timestamps
    end
    add_index :products, :slug, unique: true
  end
end
