class Item < ApplicationRecord
  belongs_to :category
  has_many :item_orders
  has_many :reviews, dependent: :destroy
  has_many :orders, through: :item_orders

  validates :name, presence: true
  validates :body, presence: true
  validates :stock, presence: true
  validates :price, presence: true

  attribute :new_item_image
  attribute :remove_item_image, :boolean
  has_one_attached :item_image

  before_save do
    if new_item_image
      self.item_image = new_item_image
    else remove_item_image
      self.item_image.purge
    end
  end

  class << self
    def search(query)
      rel = order("name")
      if query.present?
        rel = rel.where("name LIKE ?", "%#{query}%")
      end
      rel
    end
  end
end
