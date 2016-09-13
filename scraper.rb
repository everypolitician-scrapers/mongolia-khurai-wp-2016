#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'nokogiri'
require 'open-uri'

require 'scraped_page_archive/open-uri'
require 'pry'

class Khurai
  def members
    table.xpath('.//tr[td]').map do |tr|
      @tds = tr.xpath('./td')
      @cells = tr_with_district || tr_without_district
      data
    end
  end

  private

  attr_reader :cells, :tds

  def data
    {
      name: name,
      name__mn: name_mn,
      party: party,
      constituency: constituency,
      term: term,
      wikiname: wikiname,
      source: url,
    }
  end

  def name
    tds[cells[:name]].xpath('.//a').text.strip
  end

  def name_mn
    tds[cells[:name__mn]].text.strip
  end

  def party
    tds[cells[:party]].text.strip
  end

  def constituency
    'n/a'
  end

  def term
    '2016'
  end

  def wikiname
    tds[cells[:name]].xpath('.//a[not(@class="new")]/@title').text.strip
  end

  def source
    url
  end

  def url
    'https://en.wikipedia.org/wiki/'\
      'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2016'
  end

  def page
    Nokogiri::HTML(open(url).read)
  end

  def table
    page.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end

  def tr_with_district
    if tds[0][:rowspan]
      {
        name: 2,
        name__mn: 3,
        party: 5,
      }
    end
  end

  def tr_without_district
    {
      name: 1,
      name__mn: 2,
      party: 4,
    }
  end
end

Khurai.new.members.each do |mem|
  ScraperWiki.save_sqlite([:name, :term], mem)
end
