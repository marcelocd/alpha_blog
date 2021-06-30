class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name)
                          .page(params[:page])
                          .per_page(5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(valid_params)
    if@category.save
      flash[:notice] = 'Category created successfully!'
      redirect_to @category
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def valid_params
    params.require(:category)
          .permit(:name)
  end
end
