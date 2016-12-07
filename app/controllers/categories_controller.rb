class CategoriesController < ApplicationController
  before_filter :add_allow_credentials_headers

  def add_allow_credentials_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def show
    @category = Category.find(params[:id])
    @recipes = @category.recipes.page(params[:page]).per(9)
  end

  def index
    @categories = Category.all
    render json: @categories
  end
end
