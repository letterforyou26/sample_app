class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    return render :new unless @user.save

    flash[:success] = t ".general.welcome"
    redirect_to @user
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".general.user_not_found"
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
end
