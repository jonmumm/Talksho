require 'opentok'

class ShowsController < ApplicationController
  before_filter :_init

  def new
    @show = Show.new
  end

  def show
    @show = Show.find(params[:id])

    if session[@show.sessionId]
      role = OpenTok::RoleConstants::MODERATOR
    else
      role = OpenTok::RoleConstants::PUBLISHER
    end

    @token = @opentok.generate_token:session_id => @show.sessionId, :role => role
  end

  def create
    @show = Show.new(params[:show])

    @show.sessionId = @opentok.create_session.to_s

    if @show.save
      session[@show.sessionId] = true
      redirect_to @show
    else
      render :action => :new
    end
  end

  private
    def _init
      @opentok = OpenTok::OpenTokSDK.new APP_CONFIG['opentok_api_key'], APP_CONFIG['opentok_api_secret']
    end
end
