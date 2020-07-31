json.extract! poll, :id, :type, :title, :description, :start_dt, :end_dt, :status, :created_at, :updated_at
json.url poll_url(poll, format: :json)
