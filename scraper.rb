#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'nokogiri'
require 'open-uri/cached'
require_relative 'lib/table'
require_relative 'lib/row'
require_relative 'lib/page'

require 'pry'

base_url = 'https://en.wikipedia.org/wiki/'
terms = {
  2016 => 'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2016',
  2012 => 'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2012',
  2008 => 'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2008'
}

def scrape_term(term_number, url)
  Page.new(url).members.each do |mem|
    mem[:term] = term_number
    ScraperWiki.save_sqlite([:name, :term], mem)
  end
end

terms.each do |term, url|
  scrape_term(term, base_url+url)
end
