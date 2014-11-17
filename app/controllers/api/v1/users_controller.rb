class Api::V1::UsersController < ApplicationController

  respond_to :json

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_with @user
    else
      return head 400
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :username)
  end
end
