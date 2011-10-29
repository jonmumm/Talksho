class StageController < ApplicationController

  def get
    stage = Stage.where(:sessionId => params[:sessionId]).select("state, streamId")

    render :json => stage
  end

  def set
    # Only do if adminstrator
    if not session[params[:sessionId]]
      response = { :error => "User does not have privileges to perform this action" }
    else
      stage = Stage.where(:sessionId => params[:sessionId], :state => params[:state]).first

      if response
        stage.streamId = params[:streamId]
        stage.save
      else
        stage = Stage.new
        stage.sessionId = params[:sessionId]
        stage.streamId = params[:streamId]
        stage.state = params[:state]
        stage.save
      end

      response = stage
    end
    
    render :json => response
  end

end
