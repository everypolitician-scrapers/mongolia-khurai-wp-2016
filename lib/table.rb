require 'nokogiri'

class Table
  def initialize(node)
    @table = node
  end

  def rows
    constituency = nil
    table.xpath('.//tr[td]').map do |tr|
      tds = tr.xpath('./td')
      constituency = tds.shift.text.strip.gsub("\n",' — ') if tds.first[:rowspan]
      Row.new(tds).to_h.merge(constituency: constituency)
    end
  end

  private

  attr_reader :table
end
