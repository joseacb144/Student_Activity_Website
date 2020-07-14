json.extract! student, :id, :first_name, :last_name, :address, :city, :state, :zip_code, :email, :created_at, :updated_at
json.url student_show_path(student, format: :html)
