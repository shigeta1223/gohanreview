# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ時にnameを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント更新時も許可するならこちらも追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
