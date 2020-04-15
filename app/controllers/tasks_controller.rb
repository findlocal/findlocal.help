class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to dashboard_path
  end

  def destroy
    @task = Task.find(params[:id].to_i)
    @task.destroy

    flash[:alert] = "Task successfully deleted."
    redirect_to dashboard_path
  end
end
