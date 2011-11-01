require 'opentok'

class ShowsController < ApplicationController
  before_filter :_init

  def new
    @show = Show.new
    @page_title = "Create a talk show"
  end

  def show
    @show = Show.find(params[:id])

    if session[@show.sessionId]
      role = OpenTok::RoleConstants::MODERATOR
      @moderator = true
    else
      role = OpenTok::RoleConstants::PUBLISHER
      @moderator = false
    end

    @token = @opentok.generate_token:session_id => @show.sessionId, :role => role

    @page_title = @show.name
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

  def update
    @show = Show.find(params[:id])

    if session[@show.sessionId]
      @show.archiveId = params[:archiveId] 
    end

    if @show.save
      response = { :success => true }
    else
        response = { :success => false, :msg => "Problem saving state state" }
    end

    render :json => response
  end

  private
    def _init
      @opentok = OpenTok::OpenTokSDK.new APP_CONFIG['opentok_api_key'], APP_CONFIG['opentok_api_secret']
    end
end
