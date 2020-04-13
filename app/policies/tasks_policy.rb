class TasksPolicy < ApplicationPolicy
	def initialize(user, task)
    @user = user
    @task = task
	end

	def create
  end
end