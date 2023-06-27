class FoodsController < ApplicationController
    before_action :set_user, only: %i[index destroy]
    def index
        @foods = @user.foods
    end

    def destroy
        @food = @user.foods.find(params[:id])
        @food.destroy
        redirect_to user_foods_path(@user), notice: 'Food deleted successffuly'
    end

    private
    def set_user
        @user = User.find(params[:user_id])
    end
end
