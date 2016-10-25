require_relative 'nokogiri_document'
require_relative 'unspanned_table'
require_relative 'khural_member'
require_relative 'party_list_khural_member'

class MemberTable < NokogiriDocument
  def initialize(table:, member_class:)
    super(table)
    @member_class = member_class
  end

  field :members do
    table.xpath('.//tr[td]').map do |tr|
      member_class.new(tr).to_h
    end
  end

  private

  attr_reader :member_class

  def table
    UnspannedTable.new(noko).transformed
  end

  def string_class
    String
  end
end
