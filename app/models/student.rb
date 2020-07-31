class Student
  include Mongoid::Document


  has_many :purchases, dependent: :delete_all

  has_many :events, dependent: :delete_all

  has_many :polls, dependent: :delete_all

  #has_many :attending_events, inverse_of: 'attending_student', :class_name => 'Event'
  has_and_belongs_to_many :attending_events, :class_name => "Event", inverse_of: :attending_students

  has_and_belongs_to_many :voting_polls, :class_name => "Poll", inverse_of: :voting_students


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  field :first_name, type: String
  field :last_name, type: String
  field :address, type: String
  field :city, type: String
  field :state, type: String
  field :zip_code, type: String

  #specific fields for faculty
  field :department, type: String
  field :phone, type: String

  #spefecific fields for roomate
  field :roomate_flg, type:Mongoid::Boolean
  field :gender, type:String
  field :lease_start_dt, type: Date
  field :lease_end_dt, type:Date
  field :shared_cost, type:BigDecimal
  GENDER = ["Male", "Female"]

  field :created_at, type: DateTime
  field :updated_at, type: DateTime
  #credit card fields
    field :credit_card, type: String
    field :cc_expiration, type: String
    field :cc_ccv, type: String
    field :book_spent_total, type:BigDecimal
  after_create :set_spent_total

    def has_credit_card
      return self.credit_card && self.cc_expiration && self.cc_ccv
    end

    def set_spent_total
      self.book_spent_total =0
      save
    end

end
