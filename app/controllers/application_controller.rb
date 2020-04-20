class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  # See https://www.rubyguides.com/2019/11/rails-flash-messages
  add_flash_types :info, :success, :warning, :error

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |params|
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |params|
      params.permit(:first_name, :last_name, :address, :phone_number, :email, :password, :current_password)
    end
  end
end
