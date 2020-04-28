class PaymentsController < ApplicationController
  def show
    @payment = Payment.find(params[:id])
    authorize @payment
  end

  def oauth
    # this sets up a user's account to accept payments with stripe
    authorize Payment

    code = params[:code]
    begin
      response = Stripe::OAuth.token(
        {
          grant_type: "authorization_code",
          code: code
        }
      )
    rescue Stripe::OAuth::InvalidGrantError
      # status(400)
      { error: "Invalid authorization code: " + code }.to_json
      flash[:error] = "Stripe account could not be connected"

      redirect_to dashboard_path
    rescue Stripe::StripeError
      # status(500)
      { error: "An unknown error occurred." }.to_json
      flash[:error] = "Stripe account could not be connected"

      redirect_to dashboard_path
    end

    if current_user.update(stripe_account: response.stripe_user_id)
      # status(200)
      flash[:success] = "Stripe account succesfully connected"
      redirect_to dashboard_path
    else
      flash[:error] = "Stripe account could not be connected"
      redirect_to dashboard_path
    end
  end
end
