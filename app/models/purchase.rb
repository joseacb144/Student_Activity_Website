class Purchase
  include Mongoid::Document
 belongs_to :student
 belongs_to :product
 
 field :val_start_dt, type: DateTime
 field :val_end_dt, type: DateTime
 field :code, type: String
 field :total_paid, type: BigDecimal

 after_create :generate_code

 

  def generate_code
  	self.code = SecureRandom.hex
  	save
  end

end
