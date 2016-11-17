require 'scraped_page'
require_relative 'member_table'

class TermPage < ScrapedPage
  field :members do
    MemberTable.new(response: response, noko: table).members
  end

  private

  def table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end
