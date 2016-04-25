class ListioController < ApplicationController
  def index  
    @books = Book.order("last_update DESC")       
    render :action => :output
  end

  def input

  end

  def output
    @books = Book.order("last_update DESC")       
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
end
