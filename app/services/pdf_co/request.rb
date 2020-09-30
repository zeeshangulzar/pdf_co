module PdfCo
  class Request
    class << self

      SUPPORTED_METHODS = [:get, :post, :put, :delete]

      def where(resource_path, query = {}, method = :get)
        return custom_error('invalid request method',  400) unless SUPPORTED_METHODS.include?(method)

        response, status = get_json(resource_path, query, method)
        status == 200 ? response : errors(response)
      end

      def errors(response)
        error = { errors: { status: response["status"], message: response["message"] } }
        response.merge(error)
      end

      def custom_error(message,  code)
        { 'error' => { status: code, message: message } }
      end

      def get_json(root_path, query = {}, method)
        byebug
        query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
        path = query.empty?? root_path : "#{root_path}?#{query_string}"
        response = api.send(method, path)
        [JSON.parse(response.body), response.status]
      end

      def api
        Connection.api
      end
    end
  end
end
