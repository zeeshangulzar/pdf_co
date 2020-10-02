class RenderImageController < ApplicationController

  before_action :set_end_point
  before_action :set_post_method
  before_action :log_request
  before_action :validate_params
  before_action :validate_end_point

  ALLOWED_ENDPOINTS = ['png', 'jpg']

  def show
    response = PdfCo::Request.where(:post, "pdf/convert/to/#{params[:end_point]}", @log, render_params)
    return render_response(response)
  rescue => error
    internal_error_response(error)
  end

  private

  def validate_params
    if params[:url].blank?
      message = 'url field is missing'
      @log.update(error: message)
      return render json: { status: 400, error: true, message: message }
    end
  end

  def validate_end_point
    return if ALLOWED_ENDPOINTS.include?(params[:end_point])
    message = 'invalid end point'
    @log.update(error: message)
    return render json: { status: 400, error: true, message: message }
  end

  def render_params
    params.permit(:url)
  end

  def render_response(response)
    if response['error'].present?
      error_response(response)
    else
      # we can convert the url into base64 as well if required.
      return render json: { urls: response['urls'], pageCount: response['pageCount'], name: response['name'] }
    end
  end
end
