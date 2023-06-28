require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it "is expected to have many foods" do
      should respond_to(:foods)
    end

    it "is expected to have many recipes" do
      should respond_to(:recipes)
    end
  end
end
