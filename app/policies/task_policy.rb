class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    
  def resolve
    scope.where(user: current_user)
  end

  def index?
    true
  end

	def create
    new?
  end

  def new?
    user
  end

  def update?
    record.creator == user
  end

  def destroy?
    record.creator == user
  end
end
