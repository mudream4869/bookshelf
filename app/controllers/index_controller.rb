class IndexController < ApplicationController
  def index
    @books = Book.order("last_update DESC")       
  end
end
