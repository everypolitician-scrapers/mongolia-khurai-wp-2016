require 'nokogiri'

class Row
  def initialize(tds)
    @tds = tds
  end

  def to_h
    {
      name: name,
      name__mn: name_mn,
      party: party,
      term: term,
      wikiname: wikiname
    }
  end

  private

  attr_reader :tds

  def name
    tds[-4].xpath('.//a').text.strip
  end

  def name_mn
    tds[-3].text.strip
  end

  def party
    tds[-1].text.strip
  end

  def term
    '2016'
  end

  def wikiname
    tds[1].xpath('.//a[not(@class="new")]/@title').text.strip
  end
end
