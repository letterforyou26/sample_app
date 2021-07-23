class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration,
                only: %i(edit update)

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "mail_reset_pass"
      redirect_to root_url
    else
      flash.now[:danger] = t "mail_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("can_not_empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.reset_digest_after_update
      flash[:success] = t "pass_reset"
      redirect_to @user
    else
      flash[:danger] = t ".reset_failed"
      render :edit
    end
  end

  private
  def get_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "user_not_found"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])

    flash[:danger] = t "invalid_user"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "expired_pass"
    redirect_to new_password_reset_url
  end
end
