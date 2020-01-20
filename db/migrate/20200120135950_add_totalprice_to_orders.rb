class AddTotalpriceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :totalprice, :integer
  end
end
