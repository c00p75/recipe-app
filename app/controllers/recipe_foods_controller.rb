class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /recipe_foods/new
  def new
    @recipe_food = RecipeFood.new
    @foods = Food.where(user: current_user)
    @recipe = Recipe.find(params[:recipe_id])
  end

  # GET /recipe_foods/1/edit
  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @foods = Food.where(user: current_user)
    @recipe = Recipe.find(params[:recipe_id])
  end

  # POST /recipe_foods or /recipe_foods.json
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_id]

    if @recipe_food.save
      redirect_to user_recipe_path(current_user, @recipe_food.recipe_id)
    else
      flash[:alert] = 'Failed creating ingredient'
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipe_foods/1 or /recipe_foods/1.json
  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      redirect_to user_recipe_path(current_user, @recipe_food.recipe_id),
                  notice: 'Recipe food was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /recipe_foods/1 or /recipe_foods/1.json
  def destroy
    @recipe_food.destroy
    redirect_to user_recipe_path(current_user, @recipe_food.recipe_id), notice: 'Ingredient was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
