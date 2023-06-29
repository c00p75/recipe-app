class ShoppingListController < ApplicationController
  def index
    @shopping_list = []
    recipes = current_user.recipes
    recipes.each do |recipe|
      recipe_food_quantities = recipe.recipe_foods.group(:food_id).sum(:quantity)
      recipe_food_quantities.each do |food_id, quantity|
        food = Food.find(food_id)
        next unless food.quantity < quantity # if the available food amount is less than required amount

        required_quantity = quantity - food.quantity # set the food quantity to the difference
        shopping_list_item = { food:, quantity: required_quantity } # create a hash with the food and the quantity
        @shopping_list << shopping_list_item # add the food to the shopping list
      end
    end
    @total_price = 0
    @shopping_list.each do |shopping_list_item|
      @total_price += shopping_list_item[:food][:price] * shopping_list_item[:quantity]
    end
    @total_price = format('%.2f', @total_price)
  end
end
