class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def health
    render html: 'ok', layout: false
  end
end
