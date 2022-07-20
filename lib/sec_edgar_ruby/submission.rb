module SecEdgarRuby
  class Submission
    # cik: '##########'
    def self.cik_api_url(cik)
      return nil if cik.blank?

      # 10 digits with leading zeros
      cik = "%010d" % cik.to_i
      "https://data.sec.gov/submissions/CIK#{cik}.json"
    end

    # @options: { cik: 'xxx' }
    def self.find(options = {})
      result = {}
      return result if options.blank? || options[:cik].blank?

      url = cik_api_url(options[:cik])
      return result if url.blank?

      response = Faraday.get(url) do |request|
        request.headers['Accept'] = '*/*'
        request.headers['Content-Type'] = 'application/json'
        request.headers['User-Agent'] = "#{SecEdgarRuby.name}/#{SecEdgarRuby::VERSION}"
      end

      result = JSON.parse(response.body)
      Util.deep_snake_case_keys(result)
    rescue JSON::ParserError => e
      result = Hash.from_xml(response.body).as_json
      Util.deep_snake_case_keys(result)
    end
  end
end
