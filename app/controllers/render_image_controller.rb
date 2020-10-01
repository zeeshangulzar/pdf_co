class RenderImageController < ApplicationController

  before_action :validate_params
  before_action :validate_end_point

  ALLOWED_ENDPOINTS = ['png', 'jpg']

  def show
    response = PdfCo::Request.where(:post, "pdf/convert/to/#{params[:end_point]}", render_params)
    return render_response(response)
  end

  private

  def validate_params
    return render json: { status: 400, error: true, message: 'url field is missing' } if params[:url].blank?
  end

  def validate_end_point
    return if ALLOWED_ENDPOINTS.include?(params[:end_point])
    return render json: { status: 400, error: true, message: 'invalid end point' }
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
