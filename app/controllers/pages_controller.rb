class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @tasks = Task.where(status: "pending").order(:created_at)
    @location = Task.pluck(:location).uniq
    @task_tags = Tag.all.uniq
  end

   def search_location
    @task_location = Task.where('location_code LIKE ?', "%#{params[:q]}%")
    render json: @task_location
  end
end
