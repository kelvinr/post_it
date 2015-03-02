class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html{redirect_to register_path}
      format.js
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Your account has been created."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account has been updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    if current_user != @user
      flash[:error] = 'You are not allowed to do that.'
      redirect_to root_path
    end
  end
end