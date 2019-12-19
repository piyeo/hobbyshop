class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :nickname, null: false
      t.integer :sex, null: false, default: 1 #性別(男:1,女:2)
      t.string :phone, null: false
      t.string :email, null: false
      t.date :birthday
      t.string :postcode, null: false
      t.string :address, null: false
      t.string :password_digest
      t.timestamps
    end
  end
end
