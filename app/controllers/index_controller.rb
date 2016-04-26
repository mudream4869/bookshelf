class IndexController < ApplicationController
  def index
    @books = Book.order("last_update DESC")       
    if params[:tag]
      @books = @books.where(:tag => params[:tag])
    end
    if params[:sitename]
      @books = @books.where(:sitename => params[:sitename])
    end
    if params[:search]
      @books = @books.where("title LIKE ?", "%#{params[:search]}%")
    end
    @tags = Book.where("tag != ''").uniq.pluck(:tag)
    @sitenames = Book.where("sitename != ''").uniq.pluck(:sitename)
  end

  def seivenew
    @books = Book.where.not(:last_update => nil)
    @books = @books.where("last_click IS NULL OR last_click <= last_update")
    @books = @books.order("last_update DESC")
    @tags = Book.where("tag != ''").uniq.pluck(:tag)
    @sitenames = Book.where("sitename != ''").uniq.pluck(:sitename)
    render "index"
  end
end
