class UsersController < ApplicationController
  def index
    @uploads = Upload.all
    @favorites = Favorite.find(:all, :select => 'DISTINCT upload_id')
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @upload = Upload.new
    @uploads = @user.uploads
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
