class MainController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user

    if @user.admin?
      render "admin_index"
    else
      render "user_index"
    end
  end

  def admin_index
    @user = current_user
    
    if @user.admin? != true
      redirect_to root_path
    end
  end

  def user_index
  end
end
