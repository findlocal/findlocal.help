class PagesController < ApplicationController
  def home
    @tasks = Task.all
  end
end
