class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include SessionsHelper

  def after_sign_in_path_for(resource)
		root_path
	end

  def self.render_with_signed_in_user(user, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
    renderer = self.renderer.new('warden' => proxy)
    renderer.render(*args)
  end

  private

		def sign_in_required
			redirect_to new_user_session_url unless user_signed_in?
		end

    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

    # ログアウトした時もフレンドリーフォワーディング
    def after_sign_out_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || super
    end

  protected

  def configure_permitted_parameters
    added_attrs = [ :name, :number, :email, :university, :major, :picture, :password, :password_confirmation, :guide ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: [ :name, :number, :email ]
    devise_parameter_sanitizer.permit :sign_in, keys: [ :name, :email, :password, :remember_me ]
  end
end
