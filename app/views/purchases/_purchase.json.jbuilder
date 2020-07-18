json.extract! purchase, :id, :val_start_dt, :val_end_dt, :code, :total_paid, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
