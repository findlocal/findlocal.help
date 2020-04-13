class TagsController < ApplicationController
  def index
  end

  def create
  	user.creator?
  end

  def update
  	user.creator?
  end

  def destroy
  	user.creator?
  end
end
