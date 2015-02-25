class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}

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
end