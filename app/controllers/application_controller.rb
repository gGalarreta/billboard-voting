class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!, unless: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    authenticated_root_path
  end

  # Redirect to home#login after logout
  def after_sign_out_path_for(resource_or_scope)
    unauthenticated_root_path
  end
end
