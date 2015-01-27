class User < ActiveRecord::Base
  include RatingsMethods

  has_secure_password
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4,
                     message: "The password must have at least four characters"},
                     format: { with: /(.*[A-Z].*[0-9].*)|(.*[0-9].*[A-Z].*)/,
                     message: "The password must contain both capital letters and numbers"}

  has_many :ratings
  has_many :beers, through: :ratings
end
