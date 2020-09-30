module PdfCo
  class DocumentParser

    class << self

      def templates
        response = PdfCo::Request.where(:get, 'pdf/documentparser/templates', {})
        response['templates'] || response['error']
      end

      def get_results
        response = PdfCo::Request.where(:get, 'pdf/documentparser/results', { template_id: 1 })
        response['results'] || response['error']
      end

      def output_as_csv
        params = {
          url: "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/document-parser/sample-invoice.pdf",
          templateId: 1, outputFormat: 'CSV', generateCsvHeaders: true, async: false,
          encrypt: false, inline: true, password: '', storeResult: false
        }
        response = PdfCo::Request.where(:post, 'pdf/documentparser', params)
        response
      end
    end
  end
end
