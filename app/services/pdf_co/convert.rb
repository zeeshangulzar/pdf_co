module PdfCo
  class Convert

    class << self

      def to_csv
        params = {
          url: "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-csv/sample.pdf",
          lang: "eng", inline: true, unwrap: "", pages: "0-", rect: "", async: false, encrypt: false, name: "result.csv",
          password: "", lineGrouping: "", profiles: "" }
        response = PdfCo::Request.where(:post, 'pdf/convert/to/csv', params)
        response['body'] || response['error']
      end

      def to_json
        params = {
          url: "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-json/sample.pdf",
          inline: true
        }
        response = PdfCo::Request.where(:get, 'pdf/convert/to/json', params)
        response['body'] || response['error']
      end

      def to_text
        params = {
          url: "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf",
          inline: true
        }
        response = PdfCo::Request.where(:get, 'pdf/convert/to/text', params)
        response['body'] || response['error']
      end
    end
  end
end
