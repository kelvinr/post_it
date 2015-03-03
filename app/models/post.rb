class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}

  before_save :generate_slug, on: :create

  def counter(params)
    params == 'true' ? self.increment!(:vote_count) : self.decrement!(:vote_count)
  end

  def check_vote(user)
    @current_vote ||= self.votes.find_by(creator: user)
  end

  def change_vote(params)
    self.counter(params) if @current_vote.vote.to_s != params
    @current_vote.update(vote: params)
  end

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