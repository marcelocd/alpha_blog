class SessionsController < ApplicationController
  def new ; end

  def create
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      flash[:notice] = 'Logged in successfully'
      redirect_to user
    else
      flash.now[:alert] = 'There was something wrong with your login detail.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to articles_path
  end

  private

  def email
    params[:session][:email].downcase
  end

  def password
    params[:session][:password]
  end
end
