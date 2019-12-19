class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, null: false
      t.references :item, null: false
      t.integer :score, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
