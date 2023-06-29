class ApplicationController < ActionController::Base
  before_action :load_ability
  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :photo, :bio, :posts_counter) }
  end

  def load_ability
    @ability = Ability.new(current_user)
  end

  def after_sign_in_path_for(_resource)
    puts "Redirecting user to: #{users_path}"
    users_path
  end
end
