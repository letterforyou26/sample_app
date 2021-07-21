class UsersController < ApplicationController
  before_action :find_user, except: %i(new create index)
  before_action :logged_in_user, except: %i(show create new)
  before_action :correct_user, only: %i(edit update)
  before_action :admin?, only: :destroy

  def index
    @users = User.all.page(params[:page]).per Settings.items_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    return render :new unless @user.save

    flash[:success] = t "welcome"
    redirect_to @user
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      flash[:danger] = t "profile_update_fail"
      render :edit
    end
  end

  def destroy
    if current_user != @user && @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "delete_fail"
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "pls_login"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless @user == current_user
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".user_not_found"
    redirect_to root_path
  end

  def admin?
    redirect_to root_url unless current_user.admin?
  end
end
