module SecEdgarRuby
  class Submission
    # cik: '##########'
    def self.cik_api_url(cik)
      return nil if cik.blank?

      # 10 digits with leading zeros
      cik = "%010d" % cik.to_i
      "https://data.sec.gov/submissions/CIK#{cik}.json"
    end

    # @options: { cik: 'xxx', user_agent: 'Name (email)', attempts: 0 }
    def self.find(options = {})
      result = {}
      options[:user_agent] ||= "#{SecEdgarRuby.name}/#{SecEdgarRuby::VERSION}"
      options[:attempts] = options[:attempts].to_i
      return result if options.blank? || options[:cik].blank?

      url = cik_api_url(options[:cik])
      return result if url.blank?

      puts "GET: #{url}"

      response = Faraday.get(url) do |request|
        request.headers['Accept'] = '*/*'
        request.headers['Content-Type'] = 'application/json'
        request.headers['User-Agent'] = options[:user_agent]
      end

      content_type = response.headers['content-type']
      puts "Headers: #{response.headers}"

      case content_type
      when 'application/json'
        result = JSON.parse(response.body)
      when 'application/xml'
        result = Hash.from_xml(response.body).as_json
      when 'text/html'
        options[:attempts] = options[:attempts].to_i + 1
        return find(options) if options[:attempts].to_i > 2

        result = {
          error: {
            message: 'Your Request reached to limit or is rejected.',
            details: response.body
          }
        }
      else
        options[:attempts] = options[:attempts].to_i + 1
        return find(options) if options[:attempts].to_i > 2

        result = {
          error: {
            message: 'Your Request is unknown or rejected.',
            details: response.body
          }
        }
      end

      Util.deep_snake_case_keys(result)
    end
  end
end
