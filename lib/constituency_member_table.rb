require_relative 'member_table'

class ConstituencyMemberTable < MemberTable
  field :members do
    table.xpath('.//tr[td]').map do |tr|
      KhuralMember.new(tr).to_h
    end
  end
end
