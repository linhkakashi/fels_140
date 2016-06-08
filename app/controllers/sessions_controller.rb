class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      if params[:session][:remember_me] == Settings["CHECK_BOX_TRUE"]
        remember user
      else
        forget user
      end
      redirect_back_or user
    else
      flash.now[:danger] = t "notice.error_signin"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
