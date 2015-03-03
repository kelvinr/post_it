class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  validates :name, presence: true
  validates :password, length: {minimum: 5}, on: :create

  before_save :generate_slug

  def generate_slug
    self.slug = self.name.gsub(' ', '-').downcase
  end

  def to_param
    self.slug
  end
end