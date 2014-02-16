class UsersController < ApplicationController

  def new
    @user = User.new

    render(:new)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render(:new)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params

    params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :email)

  end

end