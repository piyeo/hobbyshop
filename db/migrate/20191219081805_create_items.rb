class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :category, null: false
      t.string :name, null: false
      t.text :body, null: false
      t.integer :stock, null: false
      t.integer :price, null: false
      t.date :release, null: false
      t.timestamps
    end
  end
end
