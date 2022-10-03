# frozen_string_literal: true

require 'rails_helper'
require 'shared/shared_board_context'

RSpec.describe Task, type: :model do
  include_context "with Board's context"

  before do
    valid_board.save
    valid_task_list.save
  end

  let(:time) { Time.zone.now }

  it 'saves a valid task, linked to a task list & incresase task_list count' do
    expect { valid_task.save }.to change { current_task_list.tasks.count }.by(1)
  end

  it "doesn't save a task with an invalid title" do
    valid_task.title = nil
    expect(valid_task.save).to be_falsy
  end

  it "doesn't save a task with an invalid doing time" do
    valid_task.doing_time = -1
    expect(valid_task.save).to be_falsy
  end

  it "doesn't save a task with an invalid justification" do
    valid_task.justification = nil
    expect(valid_task.save).to be_falsy
  end

  it 'does saves a task with blank started_at & finished_at params' do
    valid_task.started_at = nil
    valid_task.finished_at = nil
    expect(valid_task.save).to be_truthy
  end

  it 'updates the task title' do
    valid_task.update(title: 'Task title updated')
    expect(valid_task.title).to match('Task title updated')
  end

  it 'updates the task doing_time' do
    valid_task.update(doing_time: 2)
    expect(valid_task.doing_time).to eq(2)
  end

  it 'updates the task justification' do
    valid_task.update(justification: 'new justification')
    expect(valid_task.justification).to match('new justification')
  end

  it 'updates the task started_at' do
    valid_task.update(started_at: time)
    expect(valid_task.started_at).to match(time)
  end

  it 'updates the task finished_at' do
    valid_task.update(finished_at: time)
    expect(valid_task.finished_at).to match(time)
  end

  it 'updates the task details' do
    expect(valid_task.update(details: '<p>New task details</p>')).to be_truthy
  end

  it 'destroys task & decreases count' do
    valid_task.save
    expect { valid_task.destroy }.to change { described_class.all.count }.by(-1)
  end
end
