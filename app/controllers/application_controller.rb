class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def check_admin
    if current_user.admin != true
      redirect_to recipes_path, alert: 'Nie masz uprawnień, aby wykonać daną czynność!'
    end
  end
end
