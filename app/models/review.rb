class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :score, presence: true
  validates :body, presence: true,
    length: {maximum: 500, allow_blank: true}
end
