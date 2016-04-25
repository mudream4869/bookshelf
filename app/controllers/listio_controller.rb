class ListioController < ApplicationController
  def index  
    redirect_to "/listio/output/"
  end

  def input

  end

  def output
    @books = Book.order("last_update DESC")       
    if params[:tag]
      @books = Book.where(:tag => params[:tag])
    end
    @tags = Book.where("tag != ''").uniq.pluck(:tag)
  end

  def inputjson
    require 'base64'
    file = params[:file_content]
    file_content = file[(file.index("base64,") + 7)..-1]

    @jsonfile = Base64.decode64(file_content)
    
    puts @jsonfile
    
    @jsonarray = JSON.parse(@jsonfile)

    puts @jsonarray

    @jsonarray.each do |book|
      puts book
      @book = Book.new(book)
      @book.save
    end

    render :text => "S"
  end

  def outputtxt
    require 'json'
    @id_list = JSON.parse(params[:id_list])
    @books = Book.where(:id => @id_list) 
    
    @rettxt = ""
    
    @books.each do |book|
      @rettxt += "[" + book.sitename + "]" + book.title + "\n"
    end

    render :text => @rettxt
  end

  def outputjson
    require 'json'
    @id_list = JSON.parse(params[:id_list])
    @books = Book.where(:id => @id_list) 
    
    @retlist = []
    
    @books.each do |book|
      @retlist.append({:title => book.title, :spoturl => book.spoturl, :sitename => book.sitename})
    end

    render :text => @retlist.to_json
  end

end
