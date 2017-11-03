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

      xml.item do
        xml.title "#{change['siteName']} - #{change['siteStatus']}"
        xml.description "#{change['siteName']}#{change['country'] == 'USA' ? ', USA' : nil} #{status}"
        xml.pubDate change['date'].to_datetime.to_s(:rfc822)
        xml.link "https://supercharge.info/service/supercharge/discuss?siteId=#{change['siteId']}"
        xml.guid "https://supercharge.info/change/#{change['id']}"
      end
    end
  end
end
