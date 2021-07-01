class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create ]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to root_path
    else
      flash.now[:alert] = @post.errors.full_messages.first
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:body)
  end
end
