class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if !current_user.nil?
      @user = User.find(params[:id])
      @records = @user.records.all
    else
      flash[:danger] = "You aren't logged in!"
      redirect_to login_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You created an account! Welcome!"
      log_in(@user)
      redirect_to root_path
    else
      flash[:danger] = "Sorry, please try again."
      redirect_to register_path
    end
  end

private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :institution, :division, :email, :password,
                                 :password_confirmation)
  end

end
