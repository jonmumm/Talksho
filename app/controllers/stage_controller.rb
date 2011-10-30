require 'pusher'

Pusher.app_id = APP_CONFIG['pusher_app_id']
Pusher.key = APP_CONFIG['pusher_key']
Pusher.secret = APP_CONFIG['pusher_secret']

class StageController < ApplicationController

  def get
    stage = Stage.where(:sessionId => params[:sessionId]).select("state, streamId")

    render :json => stage
  end

  def set
    # Only do if adminstrator
    if not session[params[:sessionId]]
      response = { :success => false, :msg => "User does not have privileges to perform this action" }
    else
      stage = Stage.where(:sessionId => params[:sessionId], :state => params[:state]).first

      if stage
        stage.streamId = params[:streamId]
        stage.save
      else
        stage = Stage.new
        stage.sessionId = params[:sessionId]
        stage.streamId = params[:streamId]
        stage.state = params[:state]
        stage.save
      end

      if stage.save
        Pusher[stage.sessionId].trigger!('state', { :state => stage.state, :streamId => stage.streamId })
        response = { :success => true }
      else
        response = { :success => false, :msg => "Problem saving stage state" }
      end

    end
    
    render :json => response
  end

end
