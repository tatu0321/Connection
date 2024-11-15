# frozen_string_literal: true
module Public
  module Users
    class SessionsController < Devise::SessionsController
      before_action :initialize_resource, only: [:new]
      # before_action :configure_sign_in_params, only: [:create]

      # GET /resource/sign_in
      # def new
      #   super
      # end

      # POST /resource/sign_in
      # def create
      #   super
      # end

      # DELETE /resource/sign_out
      # def destroy
      #   super
      # end

      # protected

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_sign_in_params
      #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
      # end

      def new
        render 'public/users/sessions/new'
      end

      private

      # 初期化メソッドを追加してresourceを設定
      def initialize_resource
        self.resource = User.new
      end
    end
  end
end
