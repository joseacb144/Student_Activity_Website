class Event
  include Mongoid::Document
  field :type, type: String
  field :title, type: String
  field :description, type: String
  field :start_dt, type: DateTime
  field :end_dt, type: DateTime
  field :status, type: String
  field :address, type:String
  STATUS = ['active', 'inactive']
  TYPE = ['party', 'sports', 'general']
  belongs_to :student, inverse_of: :events
  #belongs_to :attending_student, inverse_of: :attending_events,  optional: true, :class_name => 'Student', :foreign_key => 'attending_student_id'
  has_and_belongs_to_many :attending_students, :class_name => 'Student', inverse_of: :attending_events
  validates :end_dt, presence: true
  validates :start_dt, presence: true
  validate :date_validation_current
   validate :date_validation_each


  def date_validation_each
  if self[:end_dt] < self[:start_dt] 
    errors[:end_dt] << "must be greater than Start date"
    return false
  else
    return true
  end
end

  def date_validation_current
  if self[:start_dt] < DateTime.now || self[:end_dt] < DateTime.now
    errors[:start_dt] << "must be greater Current Date"
    return false
  else
    return true
  end
end

end
