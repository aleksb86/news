class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@user, user_params)
       @user.update(user_params)
    else
      @user.update_without_password(user_params)
    end

    respond_to do |format|
      if successfully_updated
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def needs_password?(user, params)
    params[:password].present?
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :role_id)
  end
end
