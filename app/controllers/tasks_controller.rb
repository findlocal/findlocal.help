class TasksController < ApplicationController
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

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :location, :status, photos: [], tag_ids: [])
  end
  
end
