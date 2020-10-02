class ApplicationController < ActionController::Base

  def error_response(response)
    return render json: { status: response['status'], errorCode: response['errorCode'], message: response['message'] }
  end

  def internal_error_response(error)
    @log.update(error: error)
    return render json: { status: 400, error: true, message: 'internal_error' }
  end

  def set_get_method
    @method = :get
  end

  def set_post_method
    @method = :post
  end

  def set_end_point
    @end_point = "pdf/convert/to/#{params[:end_point]}"
  end

  def log_request
    @log = LogHistory.create(path: @end_point, http_type: @method, request_parameters: params)
  end
end
