json.extract! product, :id, :validity_months, :discount, :price, :type, :title, :author, :isbn, :library_location, :book_store
json.url product_url(product, format: :json)
json.buy new_product_purchase_path(product)

