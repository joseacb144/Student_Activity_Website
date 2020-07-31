class PollVote
  include Mongoid::Document

  field :name, type: String
  field :value, type: String
  field :count, type: Integer

  belongs_to :poll

end