class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(valid_params)
    if @user.save!
			flash[:notice] =
        "Welcome to the Alpha Blog, #{@user.username}! You have successfully signed up."
			redirect_to articles_path
		else
			render 'new'
		end
  end

  def edit ; end

  def update
    if @user.update!(valid_params)
			flash[:notice] = "Your account information was successfully updated!"
			redirect_to articles_path
		else
			render 'edit'
		end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def valid_params
    params.require(:user)
          .permit(:username, :email, :password)
  end
end
