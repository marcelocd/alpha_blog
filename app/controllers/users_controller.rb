class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update]
	before_action :require_same_user, only: %i[edit update destroy]

  def index
    @users = User.order(:username)
                 .page(params[:page])
                 .per_page(5)
  end

  def show
    @articles = @user.articles
                     .order(updated_at: :desc)
                     .page(params[:page])
                     .per_page(5)
  end

  def new
    @user = User.new
  end

  def create
    if @user = User.create(valid_params)
      session[:user_id] = @user.id
			flash[:notice] =
        "Welcome to the Alpha Blog, #{@user.username}! You have successfully signed up."
			redirect_to articles_path
		else
			render 'new'
		end
  end

  def edit ; end

  def update
    if @user.update(valid_params)
			flash[:notice] = "Your account information was successfully updated!"
      redirect_to @user
		else
			render 'edit'
		end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def valid_params
    params.require(:user)
          .permit(:username, :email, :password)
  end

  def require_same_user
		if current_user != @user && !current_user.admin?
			flash[:alert] = "You can only edit your own account."
			redirect_to @user
		end
	end
end
