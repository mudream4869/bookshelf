class IndexController < ApplicationController
  def index
    @books = Book.order("last_update DESC")       
    @tags = Book.where("tag != ''").uniq.pluck(:tag)
  end

  def seive
    @books = Book.where(:tag => params[:tag]).order("last_update DESC")
    @tags = Book.where("tag != ''").uniq.pluck(:tag)
    render "index"
  end

  def seivenew
    @books = Book.where.not(:last_update => nil)
    @books = @books.where("last_click IS NULL OR last_click <= last_update")
    @books = @books.order("last_update DESC")
    @tags = Book.where("tag != ''").uniq.pluck(:tag)
    render "index"
  end
end
