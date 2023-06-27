class FoodsController < ApplicationController
    def index
        @user = User.find(params[:user_id])
        @foods = @user.foods
    end
end
