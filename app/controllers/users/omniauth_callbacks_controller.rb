class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def login(name)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication 
      set_flash_message(:notice, :success, :kind => name) if is_navigational_format?
    else
      session["devise.#{name}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def facebook
    login("facebook")
  end

  def github
    login("github")
  end
  
  def google_oauth2
    login("google_oauth2")
  end
end
