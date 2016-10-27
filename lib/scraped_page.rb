class ScrapedPage
  def initialize(url)
    @url = url
  end

  private

  def noko
    @noko ||= Nokogiri::HTML(response_body)
  end

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
