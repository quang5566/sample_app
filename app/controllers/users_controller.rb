class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :find_user, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "sign_success"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    return if @user
    flash[:danger] = t "n_found"
    redirect_to root_path
  end

  def index
    @users = User.page(params[:page]).per Settings.per_sheet
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.update"
      redirect_to @user
    else
      flash[:danger] = t "users.err_update"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.deleted"
      redirect_to users_url
    else
      flash[:danger] = t "users.err_deleted"
      redirect_to users_url
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "n_found"
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "users.logged"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
