class PostsController < ApplicationController

	def index
      @posts = Post.all.order('created_at DESC')
    end
    
    def new
      @post = Post.new
    end

    def show
      @post = Post.find(params[:id])
    end
    
    def create
      # @user = current_user
      @post = Post.new(post_params)
      
      if @post.save
        redirect_to @post
      else
        render 'new'
      end
    end

    def edit
      @post = Post.find(params[:id])
    end
    
    def update
      @post = Post.find(params[:id])
      
      if @post.update(post_params)
        redirect_to @post
      else
        render 'edit'
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to root_path
    end

    private
      def post_params
        params.require(:post).permit(:title, :body, :image)
      end

      def correct_user
        @post = current_user.posts.find_by(id: params[:id])
        if @post.nil?
          flash[:alert] = "Not your post!"
          redirect_to root_path
        end
      end
end
