class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user && user.created_tasks.where(status: "pending").include?(record.task) && record.completed == false
  end

  def oauth?
    # TODO: add more rules
    user
  end
end
