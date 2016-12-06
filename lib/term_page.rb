require_relative 'constituency_member_table'
require 'nokogiri'

class TermPage < NokogiriDocument
  field :members do
    ConstituencyMemberTable.new(constituency_member_table).members
  end

  private

  def constituency_member_table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end
