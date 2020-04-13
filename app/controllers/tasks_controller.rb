class TasksController < ApplicationController
  def index
     @tasks = policy_scope(Task)
  end

  def new
    @task = Task.new
  end
  
  def edit

  end

  def create
    @task = Task.new(task_params)
    authorize @task
  end

  def update
  end

  def destroy
    @tasks = Tasks.find(params[:id])
    authorize @task
    @task.destroy
    flash[:notice] = "\"#{@task.title}\" was successfully deleted."
    redirect_to @task

  end
end
