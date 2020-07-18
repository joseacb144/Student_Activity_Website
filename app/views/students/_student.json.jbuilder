json.extract! student, :id, :first_name, :last_name, :address, :city, :state, :zip_code, :email, :department, :phone,:roomate_flg, :gender,:lease_start_dt, :lease_end_dt, :shared_cost, :created_at, :updated_at
json.url student_show_path(student, format: :html)
