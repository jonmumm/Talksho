class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_page_title

  private
    def set_page_title
      @page_title = "Talkshow"
    end
end
