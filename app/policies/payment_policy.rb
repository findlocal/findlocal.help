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
    # TODO: can this be secured further?
    user && user.stripe_account.blank?
    # signed in and doesn't already have an account
  end
end
