class User < ApplicationRecord
  validates :name, presence: true,
    format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, allow_blank: true },
    length: { minimum: 2,maximum: 12, allow_blank: true }
  validates :nickname, presence: true, length: {maximum: 20}
  validates :postcode, presence: true,
    format: { with: /\A\d{3}[-]\d{4}\z/, allow_blank: true }
  validates :address, presence: true, length: {maximum: 50}
  validates :email, email: {allow_blank: true},
    uniqueness: true
  validates :phone, presence: true,
    format: {with: /[0-9\-()]/ , allow_blank: true},
    length: {minimum: 8,maximum: 20, allow_blank: true},
    uniqueness: true
end
