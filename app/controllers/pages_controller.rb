class PagesController < ApplicationController
  def home
    @tasks = Task.all
  end

  def dashboard
    @created_tasks = current_user.created_tasks
    @helper_tasks = current_user.helper_tasks
  end
end
