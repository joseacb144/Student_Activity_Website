json.extract! student, :id, :first_name, :last_name, :address, :city, :state, :zip_code, :email, :login_id, :created_at, :updated_at
json.url student_url(student, format: :json)
