module ParcelApi
  class Error < StandardError
  end

  class NotFound < Error
  end

  class InvalidRequestError < Faraday::ResourceNotFound
  end

  class ParseError < Faraday::ParsingError
  end

end