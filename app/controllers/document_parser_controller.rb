class DocumentParserController < ApplicationController

  before_action :validate_params, only: [:index]


  def index
    response = response = PdfCo::Request.where(:post, 'pdf/documentparser', doc_params)
    if response['error'].present?
      return error_response(response)
    else
      return render json: { body: response['body'], pageCount: response['pageCount'], name: response['name'] }
    end
  end

  def templates
    response = PdfCo::Request.where(:get, 'pdf/documentparser/templates', {})
    if response['error'].present?
      return error_response(response)
    else
      return render json: { templates: response['templates'] }
    end
  end

  def results
    response = PdfCo::Request.where(:get, 'pdf/documentparser/results', { template_id: params[:id]})
    if response['error'].present?
      return error_response(response)
    else
      return render json: { templates: response['results'] }
    end
  end

  private

  def validate_params
    message =[]
    message << 'url field is missing' if params[:url].blank?
    message << 'inline field is missing' if params[:inline].blank?
    message << 'templateId field is missing' if params[:templateId].blank?
    message << 'outputFormat field is missing' if params[:outputFormat].blank?
    return render json: { status: 400, error: true, message: message } if message.present?
  end

  def doc_params
    params.require(:document_parser).permit(:url, :templateId, :outputFormat, :inline, :generateCsvHeaders, :async, :encrypt, :password, :storeResult)
  end
end
