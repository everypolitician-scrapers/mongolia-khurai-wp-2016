require_relative 'nokogiri_document'
require_relative 'unspanned_table'
require_relative 'party_list_member'

class PartyListMemberTable < NokogiriDocument
  field :members do
    table.xpath('.//tr[td]').map do |tr|
      PartyListMember.new(tr).to_h
    end
  end

  private

  def table
    UnspannedTable.new(noko).transformed
  end
end
