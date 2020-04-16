class HelpsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @help = Help.new(user: current_user, task: @task)
    flash[:alert] = @help.save ? "Applied!" : "Application did not go through"
    redirect_to dashboard_path
  end

  def update
  end

  def destroy
    @help = Help.find(params[:id].to_i)
    @help.destroy
    flash[:alert] = "Help successfully deleted"
    redirect_to dashboard_path
  end
end
