class PagesController < ApplicationController
  def home
    @tags = Tag.all

  end
end
