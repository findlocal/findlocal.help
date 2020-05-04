class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    # Add more
    # user
  end

  def create?
    # new?
  end
end
