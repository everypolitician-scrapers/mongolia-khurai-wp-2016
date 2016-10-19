require_relative 'page'
require_relative 'table'

class TermPage < Page
  def members
    Table.new(table).rows
  end

  private

  def table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end
