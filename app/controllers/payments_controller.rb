class PaymentsController < ApplicationController
  def show
    @payment = Payment.find(params[:id])
    # @task = current_user.created_tasks.where(status: "pending").find(params[:task_id])
    # @help = current_user.created_tasks.where(status: "pending").find(params[:task_id]).helps.find(params[:help_id])
    authorize @payment
  end
end
