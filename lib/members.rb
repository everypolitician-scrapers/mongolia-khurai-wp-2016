require_relative 'nokogiri_document'
require_relative 'khural_member'

class Members < NokogiriDocument
  def to_a
    constituency = nil
    noko.xpath('.//tr[td]').map do |tr|
      tds = tr.xpath('./td')
      constituency = tds.shift.text.strip.gsub("\n",' — ') if tds.first[:rowspan]
      KhuralMember.new(tds).to_h.merge(constituency: constituency)
    end
  end
end
