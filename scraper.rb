#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'scraped'
require_relative 'lib/term_page'

require 'pry'

base_url = 'https://en.wikipedia.org/wiki/'
terms = {
  2016 => 'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2016',
  2012 => 'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2012',
  2008 => 'List_of_MPs_elected_in_the_Mongolian_legislative_election,_2008',
}.map { |term, url| [term, URI.join(base_url, url).to_s] }.to_h

terms.each do |term, url|
  TermPage.new(response: Scraped::Request.new(url: url).response).members.each do |mem|
    mem[:term] = term
    mem[:source] = url
    puts mem.reject { |_, v| v.to_s.empty? }.sort_by { |k, _| k }.to_h if ENV['MORPH_DEBUG']
    ScraperWiki.save_sqlite(%i(name term), mem)
  end
end
