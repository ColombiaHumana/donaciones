json.extract! donator, :id, :doctype, :document, :firstname, :lastname, :rut_image, :doc_image, :amount, :created_at, :updated_at
json.url donator_url(donator, format: :json)
