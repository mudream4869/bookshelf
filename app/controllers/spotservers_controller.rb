class SpotserversController < ApplicationController
  def index
    @nserver = Spotserver.new()
    @servers = Spotserver.select("*")
  end
  
  def create
    @server = Spotserver.new(server_params)
    @server.save 

    redirect_to :action => "index"
  end

  def destroy
    @server = Spotserver.find(params[:id])
    @server.destroy

    redirect_to :action => "index"
  end

private

  def server_params
    params.require(:spotserver).permit(:url)
  end
end
