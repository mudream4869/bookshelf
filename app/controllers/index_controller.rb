class IndexController < ApplicationController
  def index
    if params[:new]
      @books = Book.where.not(:last_update => nil)
      @books = @books.where("last_click IS NULL OR last_click <= last_update")
      @books = @books.order("last_update DESC")       
    else
      @books = Book.order("last_update DESC")       
    end

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
    @jobs = Delayed::Job.all
    @lastjob = Delayed::Job.last
  end

end
