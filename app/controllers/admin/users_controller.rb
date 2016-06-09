class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_user
  before_action :load_user, except: :index

  def index
    @users = User.paginate page: params[:page]
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "notice.profile_update"
      redirect_to admin_user_path @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "notice.delete_success"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
