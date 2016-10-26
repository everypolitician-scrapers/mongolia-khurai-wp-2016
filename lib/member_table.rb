require_relative 'nokogiri_document'
require_relative 'unspanned_table'
require_relative 'khural_member'
require_relative 'party_list_khural_member'

class MemberTable < NokogiriDocument
  field :members do
    table.xpath('.//tr[td]').map do |tr|
      content_class.new(tr).to_h
    end
  end

  private

  attr_reader :member_class

  def table
    UnspannedTable.new(noko).transformed
  end
end
