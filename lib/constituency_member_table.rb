require_relative 'nokogiri_document'
require_relative 'unspanned_table'
require_relative 'constituency_member'

class ConstituencyMemberTable < NokogiriDocument
  field :members do
    table.xpath('.//tr[td]').map do |tr|
      ConstituencyMember.new(tr).to_h
    end
  end

  private

  def table
    UnspannedTable.new(noko).transformed
  end
end
