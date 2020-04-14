class PagesController < ApplicationController
  def home
    @tasks = Task.all
@helps = Help.all
  end
end
