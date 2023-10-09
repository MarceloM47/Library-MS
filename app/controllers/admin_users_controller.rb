class AdminUsersController < ApplicationController
  before_action :require_admin
  before_action :set_users, only: [:index, :edit, :update]

  layout "main/admin_index"

  def index
    @users
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])

    unless @user
      redirect_to admin_users_path, alert: "Usuario no encontrado"
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(admin_users_params)
        format.html { redirect_to admin_user_path(@user), notice: "El usuario ha sido actualizado con éxito" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
  
    Loan.where(user_id: @user.id).destroy_all
  
    @user.destroy
  
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "El usuario ha sido eliminado con éxito." }
    end
  end

  def search
    @q = params[:q]
    @users = User.where("dni ILIKE ?", "%#{@q}%")


    if current_user.admin?
      render layout: "main/admin_index"
    else
      render layout: "main/user_index"
    end
  end


  private
  
  def admin_users_params
    params.require(:user).permit(:name, :lastname, :dni, :email, :phone_number, :admin, :active)
  end
  
  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Acceso denegado. Debes ser un administrador."
    end
  end

  def set_users
    @users = User.all
  end
end
