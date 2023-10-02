class LoansController < ApplicationController
  before_action :set_loan, only: %i[ show edit update destroy ]
  before_action :require_admin

  layout "main/admin_index"

  # GET /loans or /loans.json
  def index
    @loans = Loan.all
  end

  # GET /loans/1 or /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    @loan = Loan.new
    @available_books = Book.where(state: true)
    @users_without_pending_loans = User.select { |user| !user.has_pending_loan? }.to_a



  end

  # GET /loans/1/edit
  def edit
    @loan = Loan.find(params[:id])
    @available_books = Book.where(state: true)

  end

  # POST /loans or /loans.json
  def create
    @loan = Loan.new(loan_params)

    @book = @loan.book

    respond_to do |format|
      if @loan.save
        @book.decrement!(:stock)
        @book.update_columns(state: false) if @book.stock.zero?
        

        format.html { redirect_to loan_url(@loan), notice: "El préstamo ha sido creado con éxito" }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1 or /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        @book.update_columns(state: false) if @book.stock.zero?

        format.html { redirect_to loan_url(@loan), notice: "El préstamo ha sido actualizado con éxito" }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1 or /loans/1.json
  def destroy
    @loan.destroy

    respond_to do |format|
      format.html { redirect_to loans_url, notice: "El préstamo ha sido eliminado con éxito" }
      format.json { head :no_content }
    end
  end

  def return_book
    @loan = Loan.find(params[:id])
  
    if @loan.returned?
      flash[:notice] = "El libro ya ha sido devuelto"
    else
      @loan.update(returned: true, return_date: Date.current)
      @loan.book.increment!(:stock)
      flash[:notice] = "Libro devuelto con éxito"
    end
  
    redirect_to return_book_loan_path(@loan)
  end


  private

    def require_admin
      unless current_user.admin?
        redirect_to root_path, alert: "Acceso denegado. Debes ser un administrador."
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(:loan_date, :return_date, :book_id, :user_id, :returned, :expected_return_date)
    end
end
