class FollowsController < ApplicationController
  def following
    @user = User.find_by(id: params[:id])
    @following = Follow.where(follow_by: @user.id)
    @followers = Follow.where(follow_to: @user.id)
  end

  def followers
    @user = User.find_by(id: params[:id])
    @following = Follow.where(follow_by: @user.id)
    @followers = Follow.where(follow_to: @user.id)
  end

  def create
    @user = User.find_by(id:params[:id])
    follow = Follow.new(follow_by: @current_user.id,
                        follow_to: params[:id])
    if follow.save
      flash[:notice] = "このユーザーをフォローしました"
      redirect_to("/users/#{@user.id}")
    end
  end

  def remove
    @user = User.find_by(id:params[:id])
    @remover = Follow.find_by(follow_by: @current_user.id,follow_to: @user.id)
    @remover.destroy
    redirect_to("/users/index")
  end
end
