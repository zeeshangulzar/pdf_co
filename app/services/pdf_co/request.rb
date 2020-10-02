module PdfCo
  class Request
    class << self

      SUPPORTED_METHODS = [:get, :post, :put, :delete]

      def where(method, resource_path, log, query = {})
        return custom_error('invalid request method',  400) unless SUPPORTED_METHODS.include?(method)
        response, status = get_json(method, resource_path, query)
        log_request(log, response, status)
        status == 200 ? response : errors(response)
      end

      def errors(response)
        error = { errors: { status: response["status"], message: response["message"] } }
        response.merge(error)
      end

      def custom_error(message,  code)
        { 'error' => { status: code, message: message } }
      end

      def get_json(method, root_path, query = {})
        query_hash = query.is_a?(Hash) ? query : query.to_unsafe_h
        query_string = query_hash.map{|k,v| "#{k}=#{v}"}.join("&")
        path = query.empty?? root_path : "#{root_path}?#{query_string}"
        response = api.send(method, path)
        [JSON.parse(response.body), response.status]
      end

      def api
        Connection.api
      end

      def log_request(log, response, status)
        log.update(response_parameters: response, response_code: status)
      end
    end
  end
end
