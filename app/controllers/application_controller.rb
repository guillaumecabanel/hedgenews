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

  def default_url_options
  { host: ENV['HOST'] || 'localhost:3000' }
  end

  private

  def set_topics
    topics_hedgy = User.find_by_email("hedgy@hedgenews.eu").topics
    if topics_hedgy.count >= 4
      @topics_nav = topics_hedgy.last(4).reverse
    else
      @topics_nav = topics_hedgy.all
    end
  end

end
