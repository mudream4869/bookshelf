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
      t_str = params[:search]
      s_str = Ropencc.conv('t2s.json', t_str)
      @books = @books.where("title LIKE ? OR title LIKE ?", 
                            "%#{t_str}%", "%#{s_str}%")
    end

    @tags = Book.where("tag != ''").uniq.pluck(:tag)
    @sitenames = Book.where("sitename != ''").uniq.pluck(:sitename)
    @jobs = Delayed::Job.all
    @lastjob = Delayed::Job.last
  end

end
