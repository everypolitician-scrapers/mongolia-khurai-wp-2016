require 'nokogiri'

class Page
  def initialize(url)
    @url = url
  end

  def members
    Table.new(table).rows
  end

  private

  attr_reader :url

  def noko
    @noko ||= Nokogiri::HTML(open(url).read)
  end

  def table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end
