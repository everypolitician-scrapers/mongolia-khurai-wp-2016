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

class Interaction
  def initialize(url)
    @url = url
  end

  def noko
    @noko ||= Nokogiri::HTML(response_body)
  end

  private

  def response
    @response ||= open(url)
  end

  def response_body
    @response_body ||=
      begin
        body = response.read
        response.rewind
        body
      end
  end

  attr_reader :url
end

terms.each do |term, url|
  TermPage.new(Interaction.new(base_url + url).noko).members.each do |mem|
    mem[:term] = term
    ScraperWiki.save_sqlite(%i(name term), mem)
  end
end
