class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    check = user&.authenticate params[:session][:password]

    return login user if check

    flash.now[:danger] = t "failed_login"
    render :new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def login user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or user
  end
end
