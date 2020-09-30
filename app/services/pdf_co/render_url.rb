module PdfCo
  class RenderUrl

    PDF_URL = 'http://www.africau.edu/images/default/sample.pdf'

    class << self
      def url_to_png
        response = PdfCo::Request.where(:post, 'pdf/convert/to/png', { url: PDF_URL})
        response['urls'] || response['error']
      end

      def url_to_jpg
        response = PdfCo::Request.where(:post, 'pdf/convert/to/jpg', { url: PDF_URL })
        response['urls'] || response['error']
      end
    end
  end
end
