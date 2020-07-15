class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

private
 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :email, :last_name, :password,:password_confirmation,:encrypted_password,
      :phone, :address, :zip_code, :state, :city, :department, :phone])

    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :email, :last_name, :password,:password_confirmation,:encrypted_password,
      :phone, :address, :zip_code, :state, :city, :department, :phone] )
 end
end
