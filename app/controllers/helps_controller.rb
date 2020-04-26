class HelpsController < ApplicationController
  before_action :set_task, only: [:create]

  def create
    binding.pry
    @help = Help.new(user: current_user, task: @task, **help_params) # use `**` to flatten the additional params
    authorize @help
    if @help.save
      flash[:success] = "Successfully applied to #{@task.title}"
    else
      flash[:error] = "There was a problem with your application, please try again"
    end
    redirect_to dashboard_path
  end

  def destroy
    @help = Help.find(params[:id])
    authorize @help
    if @help.destroy
      flash[:success] = "Application successfully removed"
    else
      flash[:error] = "There was a problem deleting your application, please try again"
    end
    redirect_to dashboard_path
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def help_params
    params.require(:help).permit(:message, :bid)
  end
end
