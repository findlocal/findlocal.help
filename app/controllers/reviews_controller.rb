class ReviewsController < ApplicationController
  def new
    @task = Task.find(params[:task_id])
    @review = Review.new(task: @task, user: current_user)
    authorize @review

    @public_review = ReviewField.new(
      name: "Public Review",
      review: @review,
      rating: nil
    )

    @private_review = ReviewField.new(
      name: "Private Suggestions or Feedback",
      rating: nil,
      review: @review
    )
  end

  def create
    authorize Review

    binding.pry
  end

  private

  def review_params
    params.require(:review)
  end
end
