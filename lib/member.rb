require 'nokogiri'
require 'field_serializer'

class Member
  include FieldSerializer

  def initialize(tds)
    @tds = tds
  end

  private

  attr_reader :tds
end
