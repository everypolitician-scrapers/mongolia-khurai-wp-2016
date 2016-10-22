require_relative 'members'
require 'field_serializer'
require 'nokogiri'

class TermPage
  include FieldSerializer

  def initialize(url)
    @url = url
  end

  field :members do
    Members.new(table).to_a
  end

  private

  attr_reader :url

  def noko
    @noko ||= Nokogiri::HTML(open(url).read)
  end

  def table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end
