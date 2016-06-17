class StaticPagesController < ApplicationController
  def home
    @user = current_user
    unless @user.nil?
      @activities = @user.activities.order(updated_at: :desc)
        .paginate(page: params[:page]).per_page Settings["ACTIVITY_PAGE_SIZE"]
    end
  end

  def help
  end

  def about
  end
end
