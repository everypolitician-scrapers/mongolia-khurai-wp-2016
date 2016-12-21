require_relative 'member_table'
require_relative 'party_list_member'

class PartyListMemberTable < MemberTable
  field :members do
    table.xpath('.//tr[td]').map do |tr|
      PartyListMember.new(noko: tr, response: response).to_h
    end
  end
end
