class StageController < ApplicationController

  def get
    render :json => params
  end

  def set
    render :json => params
  end

end
