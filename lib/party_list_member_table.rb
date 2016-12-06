require_relative 'member_table'
require_relative 'party_list_member'

class PartyListMemberTable < MemberTable
  field :members do
    table.xpath('.//tr[td]').map do |tr|
      PartyListMember.new(tr).to_h
    end
  end
end
