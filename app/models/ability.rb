class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    can :read, Recipe, public: true # Allow all users to view recipes that are public
    can :write, Recipe # Allow all users to write recipes
    can :manage, RecipeFood
    # can :manage, RecipeFood, recipe: { user_id: user.id } # Allow the user to manage their own RecipeFood records
    can :manage, Recipe, user_id: user.id # Allow the user to manage their own Recipe records
  end
end
