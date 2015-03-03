class CommentsController < ApplicationController
  before_action :require_user


  def create
    @post = Post.find_by slug: params[:post_id]
    @comment = @post.comments.new(comment_params)
    @comment.creator = current_user
    @comment.votes << Vote.create(vote: true, creator: current_user) if @comment.save

    respond_to do |format|
      format.html do
        if @comment.save
          flash[:success] = "Your comment has been added."
          redirect_to post_path(@post)
        else
          render 'posts/show'
        end
      end
      format.js
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    vote = Vote.new(voteable: @comment, creator: current_user, vote: params[:vote])
    @comment.check_vote(current_user).nil? ? vote.save : @comment.change_vote(params[:vote])
    @comment.counter(params[:vote]) if vote.persisted?

    respond_to do |format|
      format.html{redirect_to post_path(@comment.post)}
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end