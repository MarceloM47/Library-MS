class SpecialitiesController < ApplicationController
  before_action :set_speciality, only: %i[ show edit update destroy ]
  before_action :require_admin

  layout "main/admin_index"


  # GET /specialities or /specialities.json
  def index
    @specialities = Speciality.all
  end

  # GET /specialities/1 or /specialities/1.json
  def show
  end

  # GET /specialities/new
  def new
    @speciality = Speciality.new
  end

  # GET /specialities/1/edit
  def edit
  end

  # POST /specialities or /specialities.json
  def create
    @speciality = Speciality.new(speciality_params)

    respond_to do |format|
      if @speciality.save
        format.html { redirect_to speciality_url(@speciality), notice: "La especialidad ha sido creado con éxito." }
        format.json { render :show, status: :created, location: @speciality }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @speciality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /specialities/1 or /specialities/1.json
  def update
    respond_to do |format|
      if @speciality.update(speciality_params)
        format.html { redirect_to speciality_url(@speciality), notice: "La especialidad ha sido actualizada con éxito." }
        format.json { render :show, status: :ok, location: @speciality }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @speciality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specialities/1 or /specialities/1.json
  def destroy
    @speciality.destroy

    respond_to do |format|
      format.html { redirect_to specialities_url, notice: "La especialidad ha sido eliminada con éxito." }
      format.json { head :no_content }
    end
  end

  private
    def require_admin
      unless current_user.admin?
        redirect_to root_path, alert: "Acceso denegado. Debes ser un administrador."
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_speciality
      @speciality = Speciality.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def speciality_params
      params.require(:speciality).permit(:name)
    end
end
