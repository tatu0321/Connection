class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_admins_root_path # 管理者用ダッシュボードページへリダイレクト
    else
      mypage_path # ユーザーのマイページへリダイレクト
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    about_path # サインアウト後は未ログイン時のトップページ
  end

  private

  protected

  def configure_permitted_parameters
    # サインアップ時とアカウント更新時にusernameを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

end
