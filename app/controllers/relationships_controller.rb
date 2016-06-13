class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user  = User.find_by id: params[:user_id]
    relationship = params[:relationship]
    @title = t "follow_user.#{relationship}"
    @users = @user.send(relationship).paginate page: params[:page]
  end

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
