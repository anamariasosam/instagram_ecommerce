class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def instagram

    if user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect user
      session["devise.instagram_data"] = request.env["omniauth.auth"]
    else
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to root_path
  end
end
