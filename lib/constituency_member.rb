require_relative 'member'

class ConstituencyMember < Member
  field :name do
    tds[-4].xpath('.//a').text.tidy
  end

  field :name__mn do
    tds[-3].text.tidy
  end

  field :party do
    tds[-1].text.tidy
  end

  field :wikiname do
    tds[-4].xpath('.//a[not(@class="new")]/@title').text.tidy
  end

  field :constituency do
    tds[0].xpath('*').map(&:text).map(&:tidy).reject(&:empty?).join(' - ')
  end
end
