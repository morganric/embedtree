class ProfilesController < ApplicationController


  before_action :set_profile, only: [:show, :edit, :update, :destroy, :popular, :favourites]
  before_action :authenticate_user!, :except => [:show, :page, :popular, :favourites, :index]
  before_action :admin_only, :except => [:show, :page, :popular, :edit, :index, :favourites, :update]

  # GET /profiles
  # GET /profiles.json
  def index
    # @profiles = Profile.all.order('rating_number ASC').page params[:page]
    @users = User.all.order('posts_count DESC').page params[:page]

  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show

    @profile.views = @profile.views.to_i + 1
    @profile.save
    
    # @posts = Post.where(:user_id => @profile.user.id).reverse.page params[:page]
    
    @posts = Post.where(:user_id => @profile.user.id).order('created_at DESC').page params[:page]
  end

  def popular
    # @posts = Post.where(:user_id => @profile.user.id).reverse.page params[:page]
    @posts = Post.where(:user_id => @profile.user.id).order('views DESC').page params[:page]


     @profile.views = @profile.views.to_i + 1
    @profile.save
    

  end

  def favourites
    # @posts = Post.where(:user_id => @profile.user.id).reverse.page params[:page]
    @posts = @profile.user.favourites.order('created_at DESC').page params[:page]

     @profile.views = @profile.views.to_i + 1
    @profile.save
    
  end


  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
      authorize @profile
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    authorize @profile
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def admin_only
    unless current_user.admin? 
      redirect_to :root, :alert => "Access denied."
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:display_name, :bio, :image, :user_id, :slug, :website , :views, :rating_number)
    end
end
