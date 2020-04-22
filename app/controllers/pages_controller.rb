class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @tasks = Task.where.where(status: "pending").order(:created_at)
  end
end
