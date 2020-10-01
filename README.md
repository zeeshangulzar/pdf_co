# README


# How to use


# Run following commands at rails console

* PdfCo::RenderUrl.url_to_png

* PdfCo::RenderUrl.url_to_jpeg

* PdfCo::DocumentParser.templates

* PdfCo::DocumentParser.get_results

* PdfCo::DocumentParser.output_as_csv

* PdfCo::Convert.to_csv

* PdfCo::Convert.to_json

* PdfCo::Convert.to_text


# We have following end points for this. application

* /api/convert/text.json
* /api/convert/json.json
* /api/convert/csv.json

* /api/render_image/jpg.json
* /api/render_image/png.json

* /api/document_parser.json
* /api/document_parser/templates.json
* /api/document_parser/template/:id/results.json
