class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update]
  before_action :logged_in_user, :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @activities = @user.activities.order(updated_at: :desc)
      .paginate(page: params[:page]).per_page Settings["ACTIVITY_PAGE_SIZE"]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "static_pages.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "notice.update_user_success"
      redirect_to user_path @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
