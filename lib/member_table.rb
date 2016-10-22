require_relative 'nokogiri_document'
require_relative 'unspanned_table'
require_relative 'khural_member'

class MemberTable < NokogiriDocument
  field :members do
    table.xpath('.//tr[td]').map do |tr|
      KhuralMember.new(tr).to_h
    end
  end

  private

  def table
    UnspannedTable.new(noko).transformed
  end
end
