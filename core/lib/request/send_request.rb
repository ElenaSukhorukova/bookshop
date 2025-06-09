module Request
  module SendRequest
    def exec_request(url:, params: {})
      binding.pry
      conn = Faraday.new()
    end
  end
end
