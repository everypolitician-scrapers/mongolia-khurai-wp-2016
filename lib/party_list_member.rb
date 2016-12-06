require_relative 'member'

class PartyListMember < Member
  field :name do
    tds[0].text.strip
  end

  field :wikiname do
    tds[0].xpath('.//a[not(@class="new")]/@title').text.strip
  end

  field :name_mn do
    tds[1].text.strip
  end

  field :party do
    tds[3].text.strip
  end
end
