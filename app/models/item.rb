class Item < ApplicationRecord
  validates :name, presence: true
  validates :body, presence: true
  validates :stock, presence: true
  validates :price, presence: true
end
