class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.first
  end

  attr_reader :current_user
end
