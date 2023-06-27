class FoodsController < ApplicationController
  before_action :set_user, only: %i[index create destroy]
  def index
    @foods = @user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = @user.foods.new(food_params)
    if @food.save
      redirect_to user_foods_path(@user)
    else
      render :new
    end
  end

  def destroy
    @food = @user.foods.find(params[:id])
    @food.destroy
    redirect_to user_foods_path(@user), notice: 'Food deleted successffuly'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
