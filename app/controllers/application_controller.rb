class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.is_a?(Store)
      stores_dashboard_path
    elsif resource.is_a?(Customer)
      if resource.full_name?
        stored_location_for(resource) || customers_dashboard_path
      else
        customers_dashboard_path
      end
    elsif resource.is_a?(AdminUser)
      admin_dashboard_path
    else
      root_path
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :username
    end
end
