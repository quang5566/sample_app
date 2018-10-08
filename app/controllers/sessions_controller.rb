class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      user_activated user
    else
      flash.now[:danger] = t("login_error")
      render :new
    end
  end

  def show; end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_remember user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end

  def user_activated user
    if user.activated?
      login_remember user
      redirect_to user
    else
      message = t "users.active_mail"
      flash[:warning] = message
      redirect_to root_url
    end
  end
end
