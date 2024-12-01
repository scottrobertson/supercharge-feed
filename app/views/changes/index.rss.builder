xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "supercharge.info RSS feed"
    xml.description "A really simple RSS feed for supercharge.info"
    xml.link root_url

    @changes.each do |change|

      remap_status = {
        'OPEN' => 'is now open',
        'CONSTRUCTION' => 'is under construction',
        'PERMIT' => 'has a permit application',
        'CLOSED' => 'is now closed',
        'CLOSED_TEMP' => 'is temporarily closed',
        'PLAN' => 'is being planned',
        'EXPANDING' => 'is being expanded, currently',
        'VOTING' => 'has won in voting'
      }

      status = (remap_status[change['siteStatus']] || change['siteStatus'])

      # @note Remove the prefix that supercharge.info seem to be adding now
      site_name = change['siteName']
      site_name.slice!('Supercharger - ')

      site_info = @site_info[change['siteId']]

      status += " with #{site_info['stallCount']} stalls" if site_info.to_h['stallCount'].to_i > 0
      status += " (#{site_info['powerKilowatt']} kW)" if site_info.to_h['powerKilowatt'].to_i > 0

      xml.item do
        xml.title "#{site_name} - #{change['siteStatus']}"
        xml.description "#{site_name}#{change['country'] == 'USA' ? ', USA' : nil} #{status}"
        xml.pubDate change['date'].to_datetime.to_s(:rfc822)
        xml.link "https://supercharge.info/service/supercharge/discuss?siteId=#{change['siteId']}"
        xml.guid "https://supercharge.info/change/#{change['id']}"
      end
    end
  end
end
