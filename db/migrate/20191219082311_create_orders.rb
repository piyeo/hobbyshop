class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false
      t.integer :pay, null: false, default: 1 #支払い方法(1:代引き2:クレジット3:銀行振込)
      t.boolean :isDeliver, null: false, default: false
      t.boolean :isCancel, null: false, default: false
      t.timestamps
    end
  end
end
