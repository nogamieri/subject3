class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    @book_new = Book.new
    @favorite = Favorite.new
    @post_comment = PostComment.new
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    @books = Book.all
    if @book_new.save
      redirect_to book_path(@book_new.id), notice: "You have created book successfully."
    else
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @post_comment = PostComment.new
    @favorite = Favorite.new
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      render "books/edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    book = Book.find(params[:id])
    user = book.user
    if current_user != user
      redirect_to book_path
    end
  end
end
