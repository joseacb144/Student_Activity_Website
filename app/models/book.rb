class Book < Product
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :title, type: String
  field :author, type: String
  field :isbn, type: String
  field :library_location, type: String
  field :book_store, type: String

end
