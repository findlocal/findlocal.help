class PaymentsController < ApplicationController
  def new
    @task = current_user.created_tasks.where(status: "pending").find(params[:task_id])
    @help = current_user.created_tasks.where(status: "pending").find(params[:task_id]).helps.find(params[:help_id])
    authorize @task

    # @task.helper = @help.user
    # @task.status = "in progress"
  end
end
