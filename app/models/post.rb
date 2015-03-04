class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}

  before_save :generate_slug, on: :create

  def generate_slug
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug
    if post && post != self
      post = Post.order(:created_at).last
      the_slug << "-#{post.slug[/\d+$/].to_i + 1}"
    end
    self.slug = the_slug
  end

  def to_slug(name)
    str = name.strip.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, '-'
    str.downcase
  end

  def to_param
    self.slug
  end
end