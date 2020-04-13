class TagsController < ApplicationController
  def index
    @tag = policy_scope(Tag)
  end

  def new
    @tag = Tag.new
    @tag.save
  end

  def create
  	@tag = Tag.new(tag_params)
    authorize @tag
    @tag.save
  end

  def update
  	@tag = Tag.find(params[:id])
    authorize @tag
    @tag.update!
    flash[:notice] = "\"#{@tag.title}\" was successfully updated."
    redirect_to @tag
  end

  def destroy
  	@tag = Tag.find(params[:id])
    authorize @tag
    @tag.destroy
    flash[:notice] = "\"#{@tag.title}\" was successfully deleted."
    redirect_to @tag
  end
end
