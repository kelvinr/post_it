class CategoriesController < ApplicationController
  before_action :require_user, only:[:new, :create]
  before_action :require_admin, only:[:new, :create]

  def show
    @category = Category.find_by slug: params[:id]
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.html{redirect_to new_category_path}
      format.js
    end
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Your category has been created."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end