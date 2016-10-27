require_relative 'member_table'
require 'field_serializer'

class TermPage < ScrapedPage
  include FieldSerializer

  field :members do
    MemberTable.new(table).members
  end

  private

  def table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end
