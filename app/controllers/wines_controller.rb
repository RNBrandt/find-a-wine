class WinesController < ApplicationController

  def new
  end

  def create
    render plain: params[:wine].inspect
  end

end
