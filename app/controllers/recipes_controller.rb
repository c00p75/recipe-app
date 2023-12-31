class RecipesController < ApplicationController
  load_and_authorize_resource

  # GET /recipes or /recipes.json
  def index
    @user = User.find(params[:user_id])
    @recipes = @user.recipes
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @user = current_user
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.where(recipe: @recipe)
  end

  # GET /recipes/new
  def new
    @user = current_user
    @recipe = Recipe.new
  end

  # Post /recipes/patch
  def update
    @user = current_user
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to user_recipe_path(@recipe.user, @recipe), notice: 'Recipe was successfully created.' }
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @user = User.find(params[:user_id])
    @recipe.recipe_foods.destroy_all
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to user_recipes_path(@user), notice: 'Recipe was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
