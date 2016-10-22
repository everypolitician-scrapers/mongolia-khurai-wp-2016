require 'field_serializer'

class KhuralMember
  include FieldSerializer

  def initialize(tr)
    @tr = tr
  end

  field :name do
    tds[-4].xpath('.//a').text.strip
  end

  field :name_mn do
    tds[-3].text.strip
  end

  field :party do
    tds[-1].text.strip
  end

  field :term do
    '2016'
  end

  field :wikiname do
    tds[-4].xpath('.//a[not(@class="new")]/@title').text.strip
  end

  field :constituency do
    tds[0].text.strip.gsub("\n",' — ')
  end

  private

  attr_reader :tr

  def tds
    @tds ||= tr.css('td')
  end
end
