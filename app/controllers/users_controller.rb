class UsersController < ApplicationController
  before_action :set_and_authorize_task, only: [:show, :index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @users = User.all

    @completed = Task.where(helper: @user).where(status: "completed").count
    @in_progress = Task.where(helper: @user).where(status: "in progress").count
    @total = @completed + @in_progress
  end
end

private

def set_and_authorize_task
  @user = User.find(params[:id])
  authorize @user
end

def user_params
  params.require(:user).permit(:email, :first_name, :last_name, :address, :phone_number)
end
