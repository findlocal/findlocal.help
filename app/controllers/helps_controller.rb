class HelpsController < ApplicationController
  def create
    
  end

  def update
  end

  def destroy
    @help = Help.find(params[:id].to_i)
    @help.destroy

    flash[:alert] = "Help successfully deleted."
    redirect_to dashboard_path
  end
end
