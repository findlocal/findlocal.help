class ApplicationController < ActionController::Base 
include Pundit 
protect_from_forgery 

before_action :authenticate_user!

after_action :verify_authorized, except: :index , unless: :skip_pundit?
after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


def user_not_authorized
	flash[:alert] = "You do not have permission to do this!"
	redirect_to(root_path)

rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

def skip_pundit?
	devise_controller? || params[:controller] =~ /(^rails_)?admin)(^pages$)/


end
