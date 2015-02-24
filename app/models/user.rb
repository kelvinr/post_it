class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  validates :name, presence: true
  validates :password, length: {minimum: 5}, on: :create
end