class CommentsController < ApplicationController
  before_action :require_user


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.creator = current_user

    if @comment.save
      @comment.votes << Vote.create(vote: true, creator: current_user)
      flash[:success] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    v = Vote.new(voteable: @comment, creator: current_user, vote: params[:vote])
    @comment.check_vote(current_user).nil? ? v.save : @comment.change_vote(params[:vote])
    @comment.counter(params[:vote]) if v.persisted?

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end