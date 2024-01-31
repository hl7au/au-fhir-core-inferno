module Inferno
  module Utils
    # @private
    module Middleware
      class RequestLogger
        def log_response(response, start_time, end_time, exception = nil)
          elapsed = end_time - start_time
          status, _response_headers, body = response if response
          status, = response if exception

          logger.info("#{status} in #{elapsed.in_milliseconds} ms")
          return unless body.present?

          body = body.is_a?(Array) ? body.join : body

          if body.length > 100
            logger.info("#{body[0..100]}...")
          else
            logger.info(body)
          end
        end

        def log_request(env)
          method = env['REQUEST_METHOD']
          scheme = env['rack.url_scheme']
          host = env['HTTP_HOST']
          path = env['REQUEST_URI']
          query = env['rack.request.query_string']
          body = env['rack.input']
          body = body.instance_of?(Puma::NullIO) ? nil : body.string
          query_string = query.blank? ? '' : "?#{query}"

          logger.info("#{method} #{scheme}://#{host}#{path}#{query_string}")

          return unless body.present?

          if body.length > 100
            logger.info("#{body[0..100]}...")
          else
            logger.info(body)
          end
        end
      end
    end
  end
end
