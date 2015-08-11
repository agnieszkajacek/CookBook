class FavouritesController < ApplicationController
	before_filter :authenticate_user!
	def index
		@recipes=current_user.recipes
	end
	def destroy
		current_user.favourites.where(recipe_id: params[:id]).destroy_all
		redirect_to favourites_path
	end
	def create
		if current_user.favourites.where(recipe_id: params[:id]).exists?
			redirect_to favourites_path, alert: "Przepis jest już w ulubionych"
		elsif
			@recipe=Recipe.find(params[:id])
			current_user.recipes<<@recipe
			redirect_to favourites_path, notice: "Pomyślnie dodano"
		end
	end
end