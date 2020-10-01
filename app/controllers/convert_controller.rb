class ConvertController < ApplicationController

  before_action :validate_params
  before_action :validate_end_point

  ALLOWED_ENDPOINTS = ['csv', 'json', 'text']

  def show
    response = PdfCo::Request.where(:post, "pdf/convert/to/#{params[:end_point]}", convert_params)
    return render_response(response)
  end

  private

  def validate_params
    message = if params[:url].blank?
      'url field is missing'
    elsif params[:inline].blank?
      'inline field is missing'
    end
    return render json: { status: 400, error: true, message: message } if message.present?
  end

  def validate_end_point
    return if ALLOWED_ENDPOINTS.include?(params[:end_point])
    return render json: { status: 400, error: true, message: 'invalid end point' }
  end

  def convert_params
    params.permit(:url, :inline, :lang, :unwrap, :pages, :rect, :async, :encrypt, :name, :password, :lineGrouping, :profiles)
  end

  def render_response(response)
    if response['error'].present?
      return render json: { status: response['status'], errorCode: response['errorCode'], message: response['message'] }
    else
      return render json: { body: response['body'], pageCount: response['pageCount'], name: response['name'] }
    end
  end
end