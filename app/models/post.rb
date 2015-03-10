class Post < ActiveRecord::Base
  PER_PAGE = 3

  include Voteable
  include Sluggable

  default_scope { order('created_at ASC')}

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}

  sluggable_column :title
end
