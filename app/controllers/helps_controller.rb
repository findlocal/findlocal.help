class HelpsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])

    @help = Help.new()
    @help.user = current_user
    @help.task = @task
    if @help.save
      flash[:alert] = "Applied!"
      redirect_to tasks_path
    else
      flash[:alert] = "Application did not go through"
    end
  end

  def update
  end

  def destroy
    @help = Help.find(params[:id].to_i)
    @help.destroy

    flash[:alert] = "Help successfully deleted."
    redirect_to dashboard_path
  end

  private

  # def help_params
  #   params.require(:help).permit()

  # end
end
