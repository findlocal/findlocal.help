class ApplicationController < ActionController::Base
  before_action :authenticate_user! # from devise - make sure the user is logged in before each action
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  # See https://www.rubyguides.com/2019/11/rails-flash-messages
  add_flash_types :info, :success, :warning, :error

  include Pundit

  # Pundit: white-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    if current_user
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to root_path
    else
      flash[:warning] = "You must login to see this page."
      redirect_to new_user_session_path
    end
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |params|
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |params|
      params.permit(:first_name, :last_name, :address, :phone_number, :email, :password, :current_password)
    end
  end
end
