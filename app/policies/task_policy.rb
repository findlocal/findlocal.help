class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # The scope represent the model name (e.g. Task), and here I can filter records according to my policy
      # Imagine on slack, the messages you see are just the ones of your workspace, so the scope would be something like scope.where(workspace: "Le Wagon")
      scope.all
    end
  end

  # Inside a policy method, I have access just to 2 variables:
  # 1. user -> current_user
  # 2. record -> the current record (@task)

  def new?
    user # => return something truthy. `user` (`current_user`) mean that the user is logged in
  end

  def create?
    new? # directly related to new?
  end

  def edit?
    record.creator == user && record.status == "pending"
  end

  def update?
    edit? # directly related to edit?
  end

  def destroy?
    record.creator == user && record.status == "pending"
  end

  def assign?
    record.creator == user && record.status == "pending"
  end

  def dashboard?
    user
  end
end
