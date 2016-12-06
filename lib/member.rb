class Member < NokogiriDocument
  def tds
    @tds ||= noko.css('td')
  end
end
