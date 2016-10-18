#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'nokogiri'
require 'open-uri/cached'
require_relative 'lib/table'
require_relative 'lib/row'

require 'pry'

class Page
  def initialize(url)
    @url = url
  end

  def members
    Table.new(table).rows
  end

  private

  attr_reader :url

  def page
    Nokogiri::HTML(open(url).read)
  end

  def table
    page.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end

url = 'https://en.wikipedia.org/wiki/'\
      'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2016'

Page.new(url).members.each do |mem|
  ScraperWiki.save_sqlite([:name, :term], mem)
end
