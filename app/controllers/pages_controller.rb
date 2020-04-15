class PagesController < ApplicationController
  def home
    if params[:query].present?
      @tasks = Task.where("location ILIKE ?", "%#{params[:query]}%")
    else
      @tasks = Task.all
    end  
  end

  def dashboard
    @created_tasks = current_user.created_tasks
    @helper_tasks = current_user.helper_tasks
  end
end
