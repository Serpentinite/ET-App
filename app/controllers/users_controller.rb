class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[:mypage]

  def mypage
    redirect_to user_path(current_user)
  end

  def index
  end

  def show
    @user = current_user
    @records = @user.records.order(day: :desc).limit(1)
  end
end
