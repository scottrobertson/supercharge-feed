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
      }

      status = (remap_status[change['siteStatus']] || change['siteStatus'])

      # @note Remove the prefix that supercharge.info seem to be adding now
      site_name = change['siteName']
      site_name.slice!('Supercharger - ')

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
