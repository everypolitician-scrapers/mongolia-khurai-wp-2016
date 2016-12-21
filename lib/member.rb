require 'scraped'

class Member < Scraped::HTML
  def tds
    @tds ||= noko.css('td')
  end
end
