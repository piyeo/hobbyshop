class CreateItemOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :item_orders do |t|
      t.references :item, null: false
      t.references :order, null: false
      t.timestamps null: false
    end
  end
end
