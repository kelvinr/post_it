class CommentsController < ApplicationController
  before_action :require_user
  before_action :find_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:success] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = @post.comments.find(params[:id])
    Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    flash[:success] = 'Your vote was recorded'
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end