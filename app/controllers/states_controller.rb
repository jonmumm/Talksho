require 'pusher'

Pusher.app_id = APP_CONFIG['pusher_app_id']
Pusher.key = APP_CONFIG['pusher_key']
Pusher.secret = APP_CONFIG['pusher_secret']

class StatesController < ApplicationController
  def show
    states = State.where(:sessionId => params[:sessionId]).select("state, streamId, created_at")

    render :json => states
  end

  def create
    # Only do if adminstrator
    if not session[params[:sessionId]]
      response = { :success => false, :msg => "User does not have privileges to perform this action" }
    else
      if state == "guest"
        lastGuest = State.where(:sessionId => params[:sessionId], :state => params[:state]).order("created_at DESC").first
      end

      state = State.new
      state.sessionId = params[:sessionId]
      state.streamId = params[:streamId]
      state.state = params[:state]
      state.save

      if state.save
        if lastGuest
          Pusher[lastGuest.sessionId].trigger!('state', { :state => "queue", :streamId => lastGuest.streamId })
        end
        Pusher[state.sessionId].trigger!('state', { :state => state.state, :streamId => state.streamId })
        response = { :success => true }
      else
        response = { :success => false, :msg => "Problem saving state state" }
      end

    end
    
    render :json => response
  end

end
