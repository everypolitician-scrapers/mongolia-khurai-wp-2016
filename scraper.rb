#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require_relative 'lib/term_page'

require 'pry'

base_url = 'https://en.wikipedia.org/wiki/'
terms = {
  2016 => 'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2016',
  2012 => 'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2012',
  2008 => 'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2008',
}

terms.each do |term, url|
  TermPage.new(ScrapedPage.new(base_url + url).noko).members.each do |mem|
    mem[:term] = term
    ScraperWiki.save_sqlite(%i(name term), mem)
  end
end
