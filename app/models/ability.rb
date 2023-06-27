# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    can :read, Recipe, public: true # Allow all users to view recipes that are public
    can :write, Recipe # Allow all users to view recipes that are public
    can :manage, Recipe, user: user # Grant all privillages to current user
  end
end
