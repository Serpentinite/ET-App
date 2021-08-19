class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # ログイン済みユーザのみにアクセスを許可する
  before_action :authenticate_user!, except: [:guest_sign_in]

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

 
  protected
 
  def configure_permitted_parameters
    # サインアップの時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:height])
    # アカウント編集の時にnameとheightのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:height])
  end
end