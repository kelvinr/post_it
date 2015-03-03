class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
  before_action :correct_user, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{|votes| votes.vote_count}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      @post.votes << Vote.create(vote: true, creator: current_user)
      flash[:success] = "Your post has been created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "Your post was updated."
      redirect_to posts_path
    else
      render :edit
    end
  end

  def vote
    vote = Vote.new(voteable: @post, creator: current_user, vote: params[:vote])
    @post.check_vote(current_user).nil? ? vote.save : @post.change_vote(params[:vote])
    @post.counter(params[:vote]) if vote.persisted?
    
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def correct_user
    if current_user != @post.creator
      flash[:error] = "You're not allowed to do that."
      redirect_to root_path
    end
  end
end
