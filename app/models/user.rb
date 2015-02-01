class User < ActiveRecord::Base
	include AverageRating
	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, length: { minimum: 4 }, format: { with: /[A-Z]/, message: "must have at least one capitalized letter" }

	has_secure_password
	has_many :ratings
	has_many :beers, through: :ratings
end
