require 'field_serializer'
require 'nokogiri'

class NokogiriDocument
  include FieldSerializer

  def initialize(noko)
    @noko = noko
  end

  private

  attr_reader :noko
end
