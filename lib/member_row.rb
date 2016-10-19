require_relative 'row'

class MemberRow < Row
  field :name do
    tds[-4].xpath('.//a').text.strip
  end

  field :name_mn do
    tds[-3].text.strip
  end

  field :party do
    tds[-1].text.strip
  end

  field :term do
    '2016'
  end

  field :wikiname do
    tds[1].xpath('.//a[not(@class="new")]/@title').text.strip
  end
end
