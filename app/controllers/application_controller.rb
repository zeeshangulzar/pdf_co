class ApplicationController < ActionController::Base

  def error_response(response)
    return render json: { status: response['status'], errorCode: response['errorCode'], message: response['message'] }
  end
end
