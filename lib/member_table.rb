require 'scraped'
require 'table_unspanner'

class MemberTable < Scraped::HTML

  private

  def table
    # TODO: https://github.com/everypolitician/table_unspanner/issues/4
    # This line can hopefully be removed once that issue is fixed.
    return Nokogiri::HTML.parse('') if noko.empty?
    TableUnspanner::UnspannedTable.new(noko).nokogiri_node
  end
end
