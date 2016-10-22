require_relative 'khural_member'

class Members
  def initialize(node)
    @table = node
  end

  def to_a
    constituency = nil
    table.xpath('.//tr[td]').map do |tr|
      tds = tr.xpath('./td')
      constituency = tds.shift.text.strip.gsub("\n",' — ') if tds.first[:rowspan]
      KhuralMember.new(tds).to_h.merge(constituency: constituency)
    end
  end

  private

  attr_reader :table
end
