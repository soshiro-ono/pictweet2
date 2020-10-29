class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
#before_actionのifというオプションは値にメソッド名を指定することで、その戻り値がtrueであったときにのみ処理を実行するよう設定
  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    end
end
