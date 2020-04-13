class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
    
    def initialize(user, task)
    @user = user
    @task = task
	end

	def create
		user.present? #all users can create tasks
  	end

  	def update?
      user.creator? #only permit the creator of the task to update the task
  	end

  end
end
