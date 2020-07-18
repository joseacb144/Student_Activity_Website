json.extract! product, :id, :validity_months, :discount, :price, :type, :created_at, :updated_at
json.url product_url(product, format: :json)
