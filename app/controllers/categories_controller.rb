class CategoriesController < ApplicationController
	def show
		@category=Category.find(params[:id])
		@recipes=@category.recipes
	end
end