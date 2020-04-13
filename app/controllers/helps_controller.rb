class HelpsController < ApplicationController
  
  def create
  	@help = policy_scope(Help)
  end

  def destroy
  	@help.find(params[:id].to_i)
  	@help.destroy

  	flash[:alert] = "Help was deleted successfully!"
  	redirect_to tasks_path
  end
end
