class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :short]
  before_filter :authenticate_user!,  except: [:index, :show, :tag, :author, :provider, :latest]

   include PostsHelper

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order('views DESC').page params[:page]
  end

  def latest
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def author
    @author = params[:author]
    @posts = Post.where(:author => params[:author]).order('created_at DESC').page params[:page]
    @link = @posts.last.author_url
  end

  def provider
    @provider = params[:provider]
    @posts = Post.where(:provider => params[:provider]).order('created_at DESC').page params[:page]
     @link = @posts.last.provider_url
  end

  def tag
    @tag = params[:tag]
    @posts = Post.tagged_with(params[:tag]).order('created_at DESC').page params[:page]

  end

  def short
    redirect_to user_post_path(:user_id => @post.user.profile.slug, :id => @post.slug)
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    @post.views = @post.views.to_i + 1
    @post.save
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    embedly(@post)
    @post.user_id = current_user.id



    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:url, :title, :image, :thumbnail, :embed_code, :description, :author, :author_url, :provider, :provider_url, :hidden, :featured, :user_id, :views, :slug, :tag_list)
    end
end
