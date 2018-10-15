class FollowsController < ApplicationController
  before_action :logged_in_user, only: :follos

  def follows
    @title = t "micropost.#{params[:title]}"
    @user = User.find_by id: params[:id]
    @users = @user.send(params[:title]).page(params[:page])
    render :show_follow
  end

  def unfollow_user
    @user = current_user.active_relationships.find_by(followed_id: @user.id)
  end

  def follow_user
    @user = current_user.active_relationships.build
  end
end
