require_relative 'constituency_member_table'
require_relative 'party_list_member_table'
require 'nokogiri'

class TermPage < NokogiriDocument
  field :members do
    constituency_members + party_list_members
  end

  field :constituency_members do
    ConstituencyMemberTable.new(constituency_member_table).members
  end

  field :party_list_members do
    PartyListMemberTable.new(party_list_member_table).members
  end

  private

  def constituency_member_table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end

  def party_list_member_table
    noko.xpath('//h2[span[@id="Party_list"]]/following-sibling::table[@class="wikitable"]')
  end
end
