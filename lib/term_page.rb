require_relative 'member_table'
require_relative 'scraped_page'
require 'nokogiri'

class TermPage < ScrapedPage
  field :members do
    MemberTable.new(table).members
  end

  private

  def table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end
