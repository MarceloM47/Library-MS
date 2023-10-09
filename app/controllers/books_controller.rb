class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :require_admin, only: %i[ new create edit update destroy ]

  # GET /books or /books.json
  def index
    @user = current_user
    page_number = params[:page].to_i
    page_number = 1 if page_number < 1
  
    per_page = 5
    offset = (page_number - 1) * per_page
  
    @books = Book.limit(per_page).offset(offset)
    @total_pages = (Book.count.to_f / per_page).ceil
  
    if current_user.admin?
      render layout: "main/admin_index"
    else
      render layout: "main/user_index"
    end
  end

  # GET /books/1 or /books/1.json
  def show
    @user = current_user
    
    if current_user.admin?
      render layout: "main/admin_index"
    else
      render layout: "main/user_index"
    end
  end

  # GET /books/new
  def new
    @book = Book.new
    render layout: "main/admin_index"
  end

  # GET /books/1/edit
  def edit
    render layout: "main/admin_index"
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "El libro ha sido creado con éxito." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "El libro ha sido actualizado con éxito" }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "El libro ha sido eliminado con éxito" }
      format.json { head :no_content }
    end
  end

  def search
    @q = params[:q]
    @books = Book.where("title ILIKE ?", "%#{@q}%")

    if current_user.admin?
      render layout: "main/admin_index"
    else
      render layout: "main/user_index"
    end
  end

  private

    def require_admin
      unless current_user.admin?
        redirect_to root_path, notice: "Debes ser administrador."
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :image, :state, :stock)
    end
end
