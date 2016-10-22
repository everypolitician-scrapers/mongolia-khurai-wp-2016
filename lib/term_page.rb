require_relative 'member_table'
require 'nokogiri'

class TermPage
  def initialize(noko)
    @noko = noko
  end

  def members
    MemberTable.new(table).members
  end

  private

  attr_reader :noko

  def table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end
