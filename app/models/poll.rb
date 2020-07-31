class Poll
  include Mongoid::Document

  field :type, type: String
  field :title, type: String
  field :description, type: String
  field :start_dt, type: Date
  field :end_dt, type: Date
  field :status, type: String

  belongs_to :student
  has_and_belongs_to_many :voting_students, :class_name => 'Student', inverse_of: :voting_polls
  has_many :poll_votes

end
