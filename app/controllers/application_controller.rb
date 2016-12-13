class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_topics

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  private

  def set_topics
    if Topic.count >= 4
      @topics_nav = Topic.last(4).reverse
    else
      @topics_nav = Topic.all
    end
  end

end
