class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = filtered_tasks
    return if params[:search].blank?

    filter_tasks_by_search_params(params[:search])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(creator: current_user, status: "pending", **task_params) # `**` is the spread operator
    if @task.save
      flash[:success] = task_success_message("created")
      redirect_to dashboard_path
    else
      flash[:error] = task_error_message("create")
      render :new
    end
  end

  def edit; end # just the before_action

  def update
    if @task.update(task_params)
      flash[:success] = task_success_message("updated")
      redirect_to dashboard_path
    else
      flash[:error] = task_error_message("update")
      render :edit
    end
  end

  def assign
    find_and_assign_help(params)

    if @task.save
      flash[:success] = task_success_message("assigned")
    else
      flash[:error] = task_error_message("assign")
    end
    redirect_to dashboard_path
  end

  def destroy
    if @task.destroy
      flash[:success] = task_success_message("deleted")
    else
      flash[:error] = task_error_message("delete")
    end
    redirect_to dashboard_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :location, :status, photos: [], tag_ids: [])
  end

  def filtered_tasks
    Task.where("due_date > ?", Time.zone.today)
        .where(status: "pending")
        .where.not(creator: current_user)
        .order(:due_date)
  end

  def filter_tasks_by_search_params(params)
    location = params[:location]
    task_tags = params[:task_tags]
    due_date = params[:due_date].present? && Date.parse(params[:due_date])
    @tasks = @tasks.where("location ILIKE ?", "%#{location}%") unless location.empty?
    @tasks = @tasks.joins(:tags).where(tags: { name: task_tags }) unless task_tags.empty?
    @tasks = @tasks.where("due_date < ?", due_date) if due_date
  end

  def find_and_assign_help(params)
    @help = Help.find(params[:helper_id])
    @task = Task.find(params[:task_id])
    @task.helper = @help.user
    @task.status = "in progress"
  end

  def task_success_message(action)
    "Task \"#{@task.title}\" successfully #{action}"
  end

  def task_error_message(action)
    "Can't #{action} task, please check the errors and try again"
  end
end
