class HelpPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # We can use just:
  # user = current_user
  # record = @help

  def create?
    # When:
    # 1. the user is logged in
    # 2. the status is pending
    # 3. the creator of the task is not the current user (I don't apply for my task)
    # 4. the tasks the user applied for don't include the task of this help
    user && record.task.status == "pending" && record.task.creator != user && !user.helps.map(&:task).include?(record.task)
  end

  def destroy?
    # When:
    # 1. the user is logged in
    # 2. the status is pending
    # 3. the creator of the task is the current user OR the application was made by the current user
    user && record.task.status == "pending" && (record.task.creator = user || record.user = user)
  end
end
