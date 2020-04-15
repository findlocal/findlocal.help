class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.order(:due_date)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.creator = current_user
    @task.status = "pending"

    if @task.save
      flash[:success] = "\"#{@task.title}\" was created."
      redirect_to tasks_path
    else
      flash[:error] = "There was an error in creating this task"
      render :new
    end
  end

  def edit; end # just the before_action

  def update
    if @task.update(task_params)
      flash[:success] = "\"#{@task.title}\" was updated"
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error in updating this task"
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:alert] = "Task successfully deleted."
    redirect_to dashboard_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :location, :status, photos: [], tag_ids: [])
  end
end
