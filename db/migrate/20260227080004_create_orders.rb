class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price, precision: 10, scale: 2, null: false, default: 0
      t.string :status, null: false, default: 'pending'
      t.text :shipping_address
      t.string :payment_status, default: 'unpaid'

      t.timestamps
    end
  end
end
