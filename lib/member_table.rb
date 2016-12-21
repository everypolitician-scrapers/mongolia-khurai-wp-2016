require 'scraped'
require_relative 'unspanned_table'

class MemberTable < Scraped::HTML

  private

  def table
    UnspannedTable.new(noko).transformed
  end
end
