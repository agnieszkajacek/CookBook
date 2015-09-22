class RecipesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :update, :edit, :create, :destroy]
  before_filter :check_admin, except: [:show, :index]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search]).order("created_at DESC").page(params[:page]).per(9)
    else
      @recipes = Recipe.order("created_at DESC").page(params[:page]).per(9)
    end

  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    url=recipe_params[:url]
    if url.include? "kuchnialidla.pl"
      @recipe=LidlDownloader.new(url).przepis
    elsif url.include? "kwestiasmaku.com"
      @recipe=KwestiaSmakuDownloader.new(url).przepis
    elsif url.include? "tesco.pl"
      @recipe=TescoDownloader.new(url).przepis

    end
    @recipe.category_id=params[:recipe][:category_id]

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Przepis został poprawnie dodany.' }
        format.json { render :show, status: :created, location: recipes_path }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Przepis został pomyślnie zaktualizowany.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
      @recipe.destroy
        respond_to do |format|
        format.html { redirect_to recipes_url, notice: 'Przepis został poprawnie usunięty.' }
        format.json { head :no_content }
      end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :ingredients, :description, :url, :category_id)
    end
end
