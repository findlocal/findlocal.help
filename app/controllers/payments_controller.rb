class PaymentsController < ApplicationController
  def show
    @payment = Payment.find(params[:id])
    authorize @payment
  end

  def oauth
    # this sets up a user's account to accept payments with stripe
    state = params[:state]

    # TODO: create an actual state
    { error: "Incorrect state parameter: " + state }.to_json if state != "TESTSTATE"

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
    rescue Stripe::StripeError
      # status(500)
      { error: "An unknown error occurred." }.to_json
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
