require_relative 'member_table'
require 'nokogiri'

class TermPage < NokogiriDocument
  field :members do
    MemberTable.new(constituency_table, constituency_member_class).members |
    MemberTable.new(party_list_table, party_list_member_class).members
  end

  private

  def constituency_table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end

  def party_list_table
    noko.xpath('.//h2/span[text()[contains(.,"Party list")]]/following::table[1]')
  end

  def constituency_member_class
    KhuralMember
  end

  def party_list_member_class
    PartyListKhuralMember
  end
end
