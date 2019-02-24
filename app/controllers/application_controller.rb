class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include SessionsHelper

  def after_sign_in_path_for(resource)
		root_path 
	end

  private
		def sign_in_required
			redirect_to new_user_session_url unless user_signed_in?
		end

  protected

  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation, :guide ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: [ :name, :email, :password, :password_confirmation, :current_password ]
    devise_parameter_sanitizer.permit :sign_in, keys: [ :name, :email, :password, :remember_me ]
  end
end
