class CategoriesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end

  end

  def index
    @categories = Category.all
  end

  private

  def set_category
    @category = category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
