class PagesController < ApplicationController
  def home
  end

  def dashboard
    @created_tasks = current_user.created_tasks
    @helper_tasks = current_user.helper_tasks
  end
end
