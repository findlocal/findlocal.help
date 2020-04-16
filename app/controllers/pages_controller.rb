class PagesController < ApplicationController
  def home
    @tasks = Task.where("due_date > ?", Date.today).where(status: "pending").order(:due_date)[0..2]
    @help = Help.new
  end

  def dashboard
    @created_tasks = current_user.created_tasks
    @helper_tasks = current_user.helper_tasks
    @applied_to_help = current_user.applied_to_help
  end
end
