class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to '/' 
    else
      render :action => :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to '/'
    else
      render :action => :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to '/'
  end

  def click
    @book = Book.find(params[:id])
    now = DateTime.current
    @book.last_click = now
    @book.save

    redirect_to @book.spoturl
  end 

  def read
    @book = Book.find(params[:id])
    now = DateTime.current
    @book.last_click = now
    @book.save
  end

  def scan_all
    @job = Delayed::Job.enqueue(ScanAllBook.new)
    render :text => @job.id.to_s
  end

private

  def book_params
    params.require(:book).permit(:title, :sitename, :spoturl, :tag)
  end
end
