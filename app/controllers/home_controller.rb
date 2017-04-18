class HomeController < ApplicationController
  before_filter :authorize
  def index
    @posts = Post.all
    #Comment.order("post_id").each do |comment|
      #@comments << { post_id: comment.post_id, user_id: comment.user_id, content: comment.content, created_at: comment.created_at }
    #end
  end
  def comments
    @comments = Comment.where(post_id: params[:id])
    render layout: false
  end
  def add_post
    post = Post.new(:user_id => params[:post][:user_id], :content => params[:post][:content], :comment_count => 0)

    respond_to do |format|
      if @user.nil?
        format.js { render layout: false, template: "login/login_required.js.erb" }
      elsif post.save
        @posts = Post.where(id: post.id)
        format.js { render layout: false }
      else
        render :json => post.errors, :status => 422
      end
    end
  end
  def add_comment
    comment = Comment.new(:post_id => params[:comment][:post_id], :user_id => params[:comment][:user_id], :content => params[:comment][:content])

    respond_to do |format|
      if @user.nil?
        format.js { render layout: false, template: "login/login_required.js.erb" }
      elsif comment.save
        post = Post.find_by(id: params[:comment][:post_id])
        post.increment! 'comment_count', 1
        @count = post.comment_count
        @comments = Comment.where(id: comment.id)
        format.js { render layout: false }
      else
        render :json => comment.errors, :status => 422
      end
    end
  end
  def delete_post
    respond_to do |format|
      post = Post.find_by(id: params[:id])
      if @user.nil? or post.nil? or @user.id != post.user_id
        render json: nil, status: 422
      else
        post.destroy
        Comment.where(post_id: params[:id]).destroy_all
        format.js { render layout: false }
      end
    end
  end
  def delete_comment
    respond_to do |format|
      comment = Comment.find_by(id: params[:id])
      if @user.nil? or comment.nil? or @user.id != comment.user_id
        render json: nil, status: 422
      else
        @post_id = comment.post_id
        post = Post.find_by(:id => @post_id)
        comment.destroy
        post.decrement! 'comment_count', 1
        @count = post.comment_count
        format.js { render layout: false }
      end
    end
  end
  def list
    @post = Post.all
  end
end
