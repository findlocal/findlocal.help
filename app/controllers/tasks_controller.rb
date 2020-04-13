class TasksController < ApplicationController
  def index
     @task = policy_scope(Task)
  end

  def new
    @task = Task.new
    @task.save
  end
  

  def create
    @task = Task.new(task_params)
    authorize @task
    @task.save
  end

  def update
    @task = Task.find(params[:id])
    authorize @task
    @task.update!
    flash[:notice] = "\"#{@task.title}\" was successfully updated."
    redirect_to @task
  end

  def destroy
    @tasks = Tasks.find(params[:id])
    authorize @task
    @task.destroy
    flash[:notice] = "\"#{@task.title}\" was successfully deleted."
    redirect_to @task

  end
end
