class PagesController < ApplicationController
  def home
    @tasks = Task.where("due_date > ?", Time.zone.today).where(status: "pending").order(:due_date)[0..2]
  end

  def dashboard
    # No need to send any task, we can retrieve them from current_user
  end
end
