class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def correct_user
    redirect_to root_url unless current_user.is_user? @user
  end
end
