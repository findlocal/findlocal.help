class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @tasks = Task.where("due_date > ?", Time.zone.today).where(status: "pending").order(:due_date)[0..2]
  end
end
