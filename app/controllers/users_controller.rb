class UsersController < ApplicationController
 
  before_action :authenticate_user!
  # after_action :verify_authorized

   before_action :admin_only


  def index
    @users = User.all
    # authorize User
    @views = 0
    @posts = Post.all

    Post.all.each do |p|
      @views = @views + p.views
    end
  end

  def show
    @user = User.find(params[:id])
    # authorize @user

    @posts = @user.posts
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

    def admin_only
    unless current_user.admin?
      redirect_to :root, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role, :name)
  end

end
