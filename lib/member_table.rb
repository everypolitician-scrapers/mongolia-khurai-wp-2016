require 'scraped_page'
require_relative 'khural_member'

class MemberTable < ScrapedPage
  field :members do
    noko.xpath('.//tr[td]').map do |tr|
      KhuralMember.new(response: response, noko: tr).to_h
    end
  end
end
