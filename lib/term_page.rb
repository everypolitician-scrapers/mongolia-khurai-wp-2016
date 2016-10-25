require_relative 'member_table'
require 'nokogiri'

class TermPage < NokogiriDocument
  field :members do
    MemberTable.new(table: constituency_table, member_class: constituency).members |
    MemberTable.new(table: party_list_table, member_class: party_list).members
  end

  private

  def constituency_table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end

  def party_list_table
    noko.xpath('.//h2/span[text()[contains(.,"Party list")]]/following::table[1]')
  end

  def constituency
    KhuralMember
  end

  def party_list
    PartyListKhuralMember
  end
end
