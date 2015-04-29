require 'faraday'

module ParcelApi
  class Error < StandardError
  end

  class NotFound < Error
  end

  class ResourceNotFound < Error
  end

  class ConnectionFailed < Error
  end

  class ClientError < Error
  end

  class ResponseError < Faraday::Response::Middleware
    ErrorStatuses = 400...600

    def on_complete(env)
      case env[:status]
      when 404
        raise ParcelApi::ResourceNotFound, response_values(env)
      when 407
        raise ParcelApi::ConnectionFailed, %{407 "Proxy Authentication Required "}
      when ErrorStatuses
        raise ParcelApi::ClientError, response_values(env)
      end
    end

    def response_values(env)
      {status: env.status, body: env.body}
    end

  end

end