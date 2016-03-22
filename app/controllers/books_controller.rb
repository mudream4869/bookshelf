class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.save

    redirect_to '/' 
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)

    redirect_to '/'
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

  def scan_all
    @books = Book.select("*")
    now = DateTime.current

    @books.each do |book|
      if book.last_scan == nil or book.last_scan + 1.hour < now
        if book.sitename == "zizaidu"
          @tag = scan_url_zizaidu(book.spoturl)
          book.last_scan = now
          if @tag != book.scan_tag
            book.scan_tag = @tag
            book.last_update = now
            puts @tag
          end
          book.save
        end
      end
    end

    redirect_to '/'
  end

  private

  def scan_url_zizaidu(url)
    require 'open-uri'
    require 'nokogiri'
    doc = Nokogiri::HTML(open(url))
    return doc.css('a').length
  end

  def book_params
    params.require(:book).permit(:title, :sitename, :spoturl)
  end
end
