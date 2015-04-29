require 'faraday'

module ParcelApi

  # When ParcelApi Service returns an error response, it raises an error. 
  # These errors have the following ancestors:
  # ParcelApi::Error
  # ParcelApi::ResourceNotFound
  # ParcelApi::ClientError

  class Error < StandardError
  end

  class NotFound < Error
  end

  # Raised When ParcelApi returns the HTTP status code 404

  class ResourceNotFound < Error
  end

  class ConnectionFailed < Error
  end

  # Raised When ParcelApi returns the HTTP status code 40x or 50x.

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