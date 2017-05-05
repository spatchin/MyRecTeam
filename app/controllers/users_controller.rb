class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_resource, only: [:show, :edit, :update, :destroy, :profile]
  before_action :authorize_resource, except: [:show, :edit, :update, :destroy, :profile]

  def index
    @users = User.all
  end

  def edit
  end

  def show
  end

  def update
    if @user.update_attributes(resource_params)
      redirect_to users_path, notice: "User updated."
    else
      redirect_to users_path, alert: "Unable to update user."
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User deleted."
  end

  def profile
  end

  private

  def set_and_authorize_resource 
    authorize @user = User.find(params[:id])
  end

  def resource_params
    params.require(:user).permit(:role, :first_name, :last_name, :username, :email)
  end
end
