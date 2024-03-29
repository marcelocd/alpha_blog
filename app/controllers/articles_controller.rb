class ArticlesController < ApplicationController
	before_action :set_article, only: %i[show edit update destroy]
	before_action :require_user, except: %i[index show]
	before_action :require_same_user, only: %i[edit update destroy]

	def index
		@articles = Article.order(created_at: :desc)
											 .page(params[:page])
											 .per_page(5)
	end

	def show
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(valid_params)
		if @article.save
			flash[:notice] = 'Article created successfully!'
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @article.update(valid_params)
			flash[:notice] = 'Article updated successfully!'
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		redirect_to articles_path
	end

	private

	def set_article
		@article = Article.find(params[:id])
	end

	def valid_params
		params.require(:article)
					.permit(:title, :description, category_ids: [])
					.merge(user: current_user)
	end

	def require_same_user
		if current_user != @article.user && !current_user.admin?
			flash[:alert] = "You can only edit or delete your own articles."
			redirect_to @article
		end
	end
end
