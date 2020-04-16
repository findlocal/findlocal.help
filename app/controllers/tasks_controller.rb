class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.where("due_date > ?", Date.today)
                 .where(status: "pending")
                 .where.not(creator: current_user, helper: current_user)
                 .order(:due_date)
    return unless params[:search].present?

    filter_by_search_params(params[:search])
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
    flash[:alert] = "Task successfully deleted"
    redirect_to dashboard_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :location, :status, photos: [], tag_ids: [])
  end

  def filter_by_search_params(params)
    location = params[:location]
    task_tags = params[:task_tags]
    due_date = params[:due_date].present? && Date.parse(params[:due_date])
    @tasks = @tasks.where("location ILIKE ?", "%#{location}%") unless location.empty?
    @tasks = @tasks.joins(:tags).where(tags: { name: task_tags }) unless task_tags.empty?
    @tasks = @tasks.where("due_date < ?", due_date) if due_date
  end
end
