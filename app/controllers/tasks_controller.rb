class TasksController < ApplicationController
  before_action :set_task

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
    @task.destroy

    redirect_to dashboard_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :location, :photos, :status, :creator_id, :helper_id)
  end
end
