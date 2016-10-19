require_relative 'page'
require_relative 'members'

class TermPage < Page
  field :members do
    Members.new(table).to_a
  end

  private

  def table
    noko.xpath('.//h2/span[text()[contains(.,"Constituency")]]/following::table[1]')
  end
end
