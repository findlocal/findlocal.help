class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    if params[:search][:location].present? && params[:search][:task_tags].present? && params[:search][:due_date].present?

      location = params[:search][:location]
      task_tags = params[:search][:task_tags]
      due_date = Date.parse(params[:search][:due_date])

      @tasks_location_search = location.empty? ? Task.all : Task.where("location ILIKE ?", "%#{location}%")
      @tasks_tags_search = task_tags.empty? ? @tasks_location_search : @tasks_location_search.joins(:tags).where(tags: { name: task_tags })
      @tasks = due_date.to_s.empty? ? @tasks_tags_search : @tasks_tags_search.where("due_date > ?", due_date)

    elsif 
      params[:search][:location].present? && params[:search][:task_tags].present?

      location = params[:search][:location]
      task_tags = params[:search][:task_tags]

      @tasks_location_search = location.empty? ? Task.all : Task.where("location ILIKE ?", "%#{location}%")
      @tasks_tags_search = task_tags.empty? ? @tasks_location_search : @tasks_location_search.joins(:tags).where(tags: { name: task_tags })
      @tasks = due_date.to_s.empty? ? @tasks_tags_search : @tasks_tags_search.where("due_date > ?", due_date)

    elsif 
      params[:search][:task_tags].present? && params[:search][:due_date].present?

       task_tags = params[:search][:task_tags]
       due_date = Date.parse(params[:search][:due_date])

      @tasks_location_search = location.empty? ? Task.all : Task.where("location ILIKE ?", "%#{location}%")
      @tasks_tags_search = task_tags.empty? ? @tasks_location_search : @tasks_location_search.joins(:tags).where(tags: { name: task_tags })
      @tasks = due_date.to_s.empty? ? @tasks_tags_search : @tasks_tags_search.where("due_date > ?", due_date)

    elsif 
      params[:search][:location].present? && params[:search][:due_date].present?

      location = params[:search][:location]
      due_date = Date.parse(params[:search][:due_date])

      @tasks_location_search = location.empty? ? Task.all : Task.where("location ILIKE ?", "%#{location}%")
      @tasks_tags_search = task_tags.empty? ? @tasks_location_search : @tasks_location_search.joins(:tags).where(tags: { name: task_tags })
      @tasks = due_date.to_s.empty? ? @tasks_tags_search : @tasks_tags_search.where("due_date > ?", due_date)

    else
      @tasks = Task.all
    end

    @tasks.order!(:due_date)
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
