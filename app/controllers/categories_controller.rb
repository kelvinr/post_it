class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new

    if @category.save(category_params)
      flash[:notice] = "Your category has been created."
      redirect_to 
    else
      render
    end
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

end