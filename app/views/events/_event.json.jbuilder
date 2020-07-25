json.extract! event, :id, :type, :title, :description, :start_dt, :end_dt, :status, :address, :student_id
json.url event_url(event,  format: :html)
json.attend event_attend_event_path(event,  format: :js)
json.unattend event_unattend_event_path(event,  format: :js)