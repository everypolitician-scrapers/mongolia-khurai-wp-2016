#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'nokogiri'
require 'open-uri'

require 'scraped_page_archive/open-uri'
require 'pry'

class Table
  def rows
    constituency = nil
    table.xpath('.//tr[td]').map do |tr|
      tds = tr.xpath('./td')
      constituency = tds.first[:rowspan] ? tds.first.text.strip.gsub("\n",' — ') : constituency
      Row.new(tds, constituency, url).to_h
    end
  end

  private

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
end

class Row
  def initialize(node, constituency, url)
    @node = node
    @url = url
    @constituency = constituency
    @cells = tr_with_district || tr_without_district
  end

  def to_h
    {
      name: name,
      name__mn: name_mn,
      party: party,
      term: term,
      wikiname: wikiname,
      source: source,
      constituency: constituency,
    }
  end

  private

  attr_reader :node, :cells, :constituency

  def name
    node[cells[:name]].xpath('.//a').text.strip
  end

  def name_mn
    node[cells[:name__mn]].text.strip
  end

  def party
    node[cells[:party]].text.strip
  end

  def term
    '2016'
  end

  def wikiname
    node[cells[:name]].xpath('.//a[not(@class="new")]/@title').text.strip
  end

  def source
    @url
  end

  def tr_with_district
    if node.first[:rowspan]
      {
        name: 2,
        name__mn: 3,
        party: 5,
      }
    end
  end

  def tr_without_district
    unless node.first[:rowspan]
      {
        name: 1,
        name__mn: 2,
        party: 4,
      }
    end
  end
end

class Member
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def to_h
    @data.to_h
  end
end

class Khurai
  def members
    Table.new.rows do |r|
      Member.new(r)
    end
  end
end

Khurai.new.members.each do |mem|
  ScraperWiki.save_sqlite([:name, :term], mem)
end
