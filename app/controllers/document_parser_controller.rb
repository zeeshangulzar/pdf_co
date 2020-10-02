class DocumentParserController < ApplicationController

  before_action :set_end_point
  before_action :set_get_method, except: [:index]
  before_action :set_post_method, only: [:index]
  before_action :log_request
  before_action :validate_params, only: [:index]


  def index
    response = response = PdfCo::Request.where(:post, 'pdf/documentparser', @log, doc_params)
    if response['error'].present?
      return error_response(response)
    else
      return render json: { body: response['body'], pageCount: response['pageCount'], name: response['name'] }
    end
  rescue => error
    internal_error_response(error)
  end

  def templates
    response = PdfCo::Request.where(:get, 'pdf/documentparser/templates', @log, {})
    if response['error'].present?
      return error_response(response)
    else
      return render json: { templates: response['templates'] }
    end
  rescue => error
    internal_error_response(error)
  end

  def results
    response = PdfCo::Request.where(:get, 'pdf/documentparser/results', @log, { template_id: params[:id]})
    if response['error'].present?
      return error_response(response)
    else
      return render json: { templates: response['results'] }
    end
  rescue => error
    internal_error_response(error)
  end

  private

  def set_end_point
    @end_point = "pdf/convert/to/#{params[:action]}"
  end

  def validate_params
    message =[]
    message << 'url field is missing' if params[:url].blank?
    message << 'inline field is missing' if params[:inline].blank?
    message << 'templateId field is missing' if params[:templateId].blank?
    message << 'outputFormat field is missing' if params[:outputFormat].blank?
    if message.present?
      @log.update(error: message)
      return render json: { status: 400, error: true, message: message }
    end
  end

  def doc_params
    params.require(:document_parser).permit(:url, :templateId, :outputFormat, :inline, :generateCsvHeaders, :async, :encrypt, :password, :storeResult)
  end
end
