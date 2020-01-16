class User < ApplicationRecord
  has_secure_password

  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true,
    format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, allow_blank: true },
    length: { minimum: 2,maximum: 15, allow_blank: true }
  validates :nickname, presence: true,
    length: {minimum: 2,maximum: 15, allow_blank: true}
  validates :postcode, presence: true,
    format: { with: /\A\d{3}[-]\d{4}\z/, allow_blank: true }
  validates :address, presence: true, length: {maximum: 50}
  validates :email, presence: true, email: {allow_blank: true},
    uniqueness: true
  validates :phone, presence: true,
    format: {with: /[0-9\-()]/ , allow_blank: true},
    length: {minimum: 8,maximum: 20, allow_blank: true},
    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 } ,allow_nil: true

end
