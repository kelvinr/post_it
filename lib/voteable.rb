#Using Concerns
module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def counter(params)
    params == 'true' ? self.increment!(:vote_count) : self.decrement!(:vote_count)
  end

  def check_vote(user)
    @current_vote ||= self.votes.find_by(creator: user)
  end

  def change_vote(params)
    self.count(params) if @current_vote.vote.to_s != params
    @current_vote.update(vote: params)
  end
end

# Using normal metaprogramming
=begin
module Voteable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_method
    end
  end

  module InstanceMethods
    def counter(params)
      params == 'true' ? self.increment!(:vote_count) : self.decrement!(:vote_count)
    end

    def check_vote(user)
      @current_vote ||= self.votes.find_by(creator: user)
    end

    def change_vote(params)
      self.count(params) if @current_vote.vote.to_s != params
      @current_vote.update(vote: params)
    end
  end

  module ClassMethods
    def my_class_method
      has_many :votes, as: :voteable
    end
  end
end
=end