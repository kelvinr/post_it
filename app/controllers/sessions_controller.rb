class SessionsController < ApplicationController

  def new
    respond_to do |format|
      format.html{redirect_to login_path}
      format.js
    end
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        login_user!(user)
      end
    else
      flash.now[:error] = "Username or password is incorrect, please try again."
      render :new
    end
  end

  def pin
    access_denied if session[:two_factor].nil?

    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user!(user)
      else
        flash[:error] = "Sorry, something is wrong with your pin number."
        redirect_to pin_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You are now logged out."
    redirect_to root_path
  end

  def login_user!(user)
    session[:user_id] = user.id
    flash[:success] = "You've logged in."
    redirect_to root_path
  end
  private

end
