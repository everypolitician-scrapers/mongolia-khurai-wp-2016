require 'field_serializer'
require 'nokogiri'

class NokogiriDocument
  include FieldSerializer

  def initialize(noko, content_class = nil)
    @noko = noko
    @content_class = content_class
  end

  private

  attr_reader :noko, :content_class
end
