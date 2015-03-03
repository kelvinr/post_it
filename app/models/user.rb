class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  validates :name, presence: true
  validates :password, length: {minimum: 5}, on: :create

  before_save :generate_slug, on: :create

 def generate_slug
     the_slug = to_slug(self.name)
     user = User.find_by slug: the_slug
     if user && user != self
       user = User.order(:created_at).last
       the_slug << "-#{user.slug[/\d+$/].to_i + 1}"
     end
     self.slug = the_slug
   end

   def to_slug(username)
     str = username.strip.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
     str.gsub! /-+/, '-'
     str.downcase
   end

  def to_param
    self.slug
  end
end