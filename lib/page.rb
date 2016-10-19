require 'field_serializer'
require 'nokogiri'

class Page
  include FieldSerializer

  def initialize(url)
    @url = url
  end

  private

  attr_reader :url

  def noko
    @noko ||= Nokogiri::HTML(open(url).read)
  end
end
