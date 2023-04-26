json.extract! task, :id, :name, :description, :days, :days_left, :priority, :status, :project_id, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)
