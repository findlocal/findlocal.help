class TasksController < ApplicationController
  def index
     @tasks = policy_scope(Tasks)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @tasks = Tasks.find(params[:id])
    authorize @tasks

    @tasks.destroy
    flash[:notice] = "\"#{@tasks.title}\" was successfully deleted."
    redirect_to @tasks
  end
end
