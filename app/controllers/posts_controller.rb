class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit,:update,:destroy]}

  def index
    @post = Post.new
    #TLに表示すべきユーザーのID一覧を取得
    @timeline_users = Array.new
    @current_user_following = Follow.where(follow_by:@current_user.id)
    @current_user_following.each do |cuf|
      @timeline_users.push(cuf.follow_to)
    end
    @timeline_users.push(@current_user.id)
    #取得終わり。timeline_usersにフォロー中+自分のIDが配列で格納される。

    #タイムラインに表示すべきpostを新しい順に格納
    @orderd_timeline = Post.where(user_id: @timeline_users).order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id:@post.id).count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to("/posts/index")
    else
      flash[:notice] = "投稿に失敗しました"
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit") #renderはこのアクション内の@postの中身をrender先の@postに入れることが出来る。
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
