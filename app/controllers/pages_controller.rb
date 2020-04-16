class PagesController < ApplicationController
  def home
  	@location = Task.pluck(:location).uniq
  end

  def dashboard
    @created_tasks = current_user.created_tasks
    @helper_tasks = current_user.helper_tasks
    @applied_to_help = current_user.applied_to_help
  end
end
