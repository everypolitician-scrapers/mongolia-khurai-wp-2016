require 'nokogiri'
require 'scraped_page'
require_relative 'unspanned_table'

class UnspanAllTables < ScrapedPage::Processor
  def body
    Nokogiri::HTML(response.body).tap do |doc|
      doc.css('table').each do |table|
        table.children = UnspannedTable.new(table).transformed.children
      end
    end.to_s
  end
end
