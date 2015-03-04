class User < ActiveRecord::Base
  include Sluggable
  
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  validates :name, presence: true
  validates :password, length: {minimum: 5}, on: :create

  sluggable_column :name
end