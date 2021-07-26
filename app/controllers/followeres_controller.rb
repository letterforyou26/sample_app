class FolloweresController < ApplicationController
  before_action :logged_in_user, :find_user

  def index
    @title = t "follow.followers"
    @users = @user.followers.page(params[:page])
                  .per Settings.follow_per_page
  end
end
