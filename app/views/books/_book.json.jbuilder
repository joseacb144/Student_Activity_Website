json.extract! book, :id, :title, :author, :isbn, :library_location, :book_store, :price, :created_at, :updated_at
json.url book_url(book, format: :json)
