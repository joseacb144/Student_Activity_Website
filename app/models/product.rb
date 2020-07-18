class Product
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  has_many :purchases

  field :validity_months, type: Integer
  field :discount, type: BigDecimal
  field :price, type: BigDecimal
  field :_type, type: String

  alias_attribute :type, :_type

  validates :type, presence: true

  scope :books, -> { where(type: 'Book') }
	scope :bus_tickets, -> { where(type: 'BusTicket') }
	scope :meals, -> { where(type: 'Meal') }

   class << self
    def types
      %w(Meal BusTicket Book)
    end
  end

  def name
  	if self.type =="Meal"
  		self.plan
  	elsif self.type =="BusTicket"
  		self.zone
  	elsif self.type == "Book"
  		self.title
  	end
  end


end
