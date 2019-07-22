class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :show, :destroy]
  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def confirm
    @blog = Blog.new(blog_params)

  end

  def create
    if blog_params[:content].size >= 1 && blog_params[:content].size <= 140
      @blog = Blog.create(blog_params)
      if @blog.save
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render 'new'
      end
    else
      redirect_to blogs_path, notice: "送信に失敗しました。コメントは1〜140字でお願いいたします。"
    end
  end

  def edit
  end

  def update
    @blog = Blog.find(params[:id])
    if blog_params[:content].size >= 1 && blog_params[:content].size <= 140
      if @blog.update(blog_params)
        redirect_to blogs_path, notice: "ブログを編集しました"
      else
        render 'edit'
      end
    else
      redirect_to blog_path, notice: "送信に失敗しました。コメントは1〜140字でお願いいたします。"
    end
  end

  def show
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました"
  end

  private
  def blog_params
    params.require(:blog).permit(:id, :created_at, :title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
