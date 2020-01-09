class Item < ApplicationRecord
  belongs_to :category
  has_many :item_orders
  has_many :orders, through: :item_orders
  validates :name, presence: true
  validates :body, presence: true
  validates :stock, presence: true
  validates :price, presence: true
end
