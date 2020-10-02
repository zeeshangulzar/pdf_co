class ConvertController < ApplicationController

  before_action :set_end_point
  before_action :set_post_method
  before_action :log_request
  before_action :validate_params
  before_action :validate_end_point

  ALLOWED_ENDPOINTS = ['csv', 'json', 'text']

  def show
    response = PdfCo::Request.where(:post, "pdf/convert/to/#{params[:end_point]}", @log, convert_params)
    return render_response(response)
  rescue => error
    internal_error_response(error)
  end

  private

  def validate_params
    message = []
    message << 'url field is missing'if params[:url].blank?
    message << 'inline field is missing' if params[:inline].blank?
    if message.present?
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

  def convert_params
    params.permit(:url, :inline, :lang, :unwrap, :pages, :rect, :async, :encrypt, :name, :password, :lineGrouping, :profiles)
  end

  def render_response(response)
    if response['error'].present?
      error_response(response)
    else
      return render json: { body: response['body'], pageCount: response['pageCount'], name: response['name'] }
    end
  end
end
