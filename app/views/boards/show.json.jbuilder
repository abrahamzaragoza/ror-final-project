json.board do
  json.extract! @board, :id, :title, :visibility, :created_at, :updated_at
  json.task_lists @task_lists do |list|
    json.extract! list, :id, :name, :color, :priority, :board_id, :created_at, :updated_at, :tasks
  end
end

