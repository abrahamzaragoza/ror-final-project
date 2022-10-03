# frozen_string_literal: true

RSpec.shared_context "with Board's context" do
  let(:valid_board) do
    Board.new(
      title: 'Board title',
      visibility: 'public'
    )
  end

  let(:valid_task_list) do
    TaskList.new(
      name: 'Task name',
      color: '#3696bc',
      priority: 'important',
      board_id: current_board.id
    )
  end

  let(:valid_task) do
    Task.new(
      title: 'Task title example',
      started_at: Time.zone.now,
      finished_at: Time.zone.now,
      doing_time: 4,
      justification: 'Justification example',
      details: '<p>Some rich text example</p>',
      task_list_id: current_task_list.id
    )
  end

  def current_board
    Board.first
  end

  def current_task_list
    TaskList.first
  end
end
