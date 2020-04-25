class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user && user.created_task.where(status: "pending").include?(params[:task_id]) && !params[:task_id].checkout_session_id.nil?
    # user
  end
end
