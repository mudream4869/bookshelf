class IndexController < ApplicationController
  def index
    @books = Book.order("last_update DESC")       
    @tags = Book.where("tag != ''").uniq.pluck(:tag)
    @sitenames = Book.where("sitename != ''").uniq.pluck(:sitename)
  end

  def seivetag
    @books = Book.where(:tag => params[:tag]).order("last_update DESC")
    @tags = Book.where("tag != ''").uniq.pluck(:tag)
    @sitenames = Book.where("sitename != ''").uniq.pluck(:sitename)
    render "index"
  end

  def seivesitename
    @books = Book.where(:sitename => params[:sitename]).order("last_update DESC")
    @tags = Book.where("tag != ''").uniq.pluck(:tag)
    @sitenames = Book.where("sitename != ''").uniq.pluck(:sitename)
    render "index"
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
