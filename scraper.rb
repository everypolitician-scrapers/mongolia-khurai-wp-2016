#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'nokogiri'
require 'open-uri/cached'
require_relative 'lib/table'
require_relative 'lib/row'
require_relative 'lib/page'

require 'pry'

url = 'https://en.wikipedia.org/wiki/'\
      'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2016'

Page.new(url).members.each do |mem|
  ScraperWiki.save_sqlite([:name, :term], mem)
end
