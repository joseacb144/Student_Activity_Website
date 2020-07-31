json.items @products do |item|
	json.partial! "products/product", product: item
end
