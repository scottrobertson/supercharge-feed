class ChangesController < ApplicationController
  def index
    @changes = JSON.parse(RestClient.get('https://supercharge.info/service/supercharge/allChanges'))
    @changes = @changes.select{|d| d['country'].downcase == params[:country].downcase } if params[:country].present?
    @changes = @changes.select{|d| d['region'].downcase == params[:region].downcase } if params[:region].present?

    @site_info = JSON.parse(RestClient.get('https://supercharge.info/service/supercharge/allSites')).map{|s| [s['id'], s] }.to_h

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
