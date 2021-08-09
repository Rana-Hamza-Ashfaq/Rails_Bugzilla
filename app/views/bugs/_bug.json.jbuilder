json.extract! bug, :id, :title, :description, :due_date, :bugtype, :status, :created_at, :updated_at
json.url bug_url(bug, format: :json)
