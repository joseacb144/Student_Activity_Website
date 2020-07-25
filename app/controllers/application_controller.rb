class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

private
 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :email, :last_name, :password,:password_confirmation,:encrypted_password,
      :phone, :address, :zip_code, :state, :city, :department, :phone, :roomate_flg, :gender, :lease_start_dt, :lease_end_dt, :shared_cost, :credit_card,
       :cc_expiration, :cc_ccv, :move_in_date])

    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :email, :last_name, :password,:password_confirmation,:encrypted_password,
      :phone, :address, :zip_code, :state, :city, :department, :phone, :roomate_flg, :gender,:lease_start_dt, :lease_end_dt, :shared_cost, :credit_card,
       :cc_expiration, :cc_ccv, :move_in_date] )
 end
end
