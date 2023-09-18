class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :require_admin, only: %i[ new create edit update destroy ]

  # GET /books or /books.json
  def index
    @user = current_user
    @books = Book.all
    if current_user.admin?
      render layout: "main/admin_index"
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
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    render layout: "main/admin_index"
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    render layout: "main/admin_index"
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
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
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :image, :state)
    end
end
