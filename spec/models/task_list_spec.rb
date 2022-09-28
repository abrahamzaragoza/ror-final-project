# frozen_string_literal: true

require 'rails_helper'
require 'shared/shared_board_context.rb'

RSpec.describe TaskList, type: :model do
  include_context "Board's context"

  before do
    valid_board.save
  end

  it 'saves a valid task list, linked to the current board' do
    expect(valid_task_list.save).to be_truthy
  end

  it "doesn't save a task list without a board id" do
    valid_task_list.board_id = nil
    expect(valid_task_list.save).to be_falsy
  end

  it "saves task list & increseare board's task list count" do
    expect { valid_task_list.save }.to change { current_board.task_lists.all.count }.by(1)
  end

  it 'destroys task lists linked to a board, after removing the board' do
    valid_task_list.save
    current_board.destroy
    expect(TaskList.count).to eq(0)
  end

  it "doesn't save a task list with an invalid name" do
    valid_task_list.name = ''
    expect(valid_task_list.save).to be_falsy
  end

  it "doesn't save a task list with an invalid color" do
    valid_task_list.color = nil
    expect(valid_task_list.save).to be_falsy
  end

  it 'color param has to begin with #' do
    expect(/^#[a-zA-Z0-9]*/).to match(valid_task_list.color)
  end

  it 'color param must be a minimum 4 characters' do
    valid_task_list.color = '#aa'
    valid_task_list.save
    expect(valid_task_list.errors.first.message).to match('is too short (minimum is 4 characters)')
  end

  it 'color param must be a maximum 7 characters' do
    valid_task_list.color = '#aaaaaaa'
    valid_task_list.save
    expect(valid_task_list.errors.first.message).to match('is too long (maximum is 7 characters)')
  end

  it 'color param must be a be a valid hexadecimal value' do
    valid_task_list.color = 'string'
    valid_task_list.save
    expect(valid_task_list.errors.first.message).to match('Only hexadecimal values allowed')
  end

  it 'decreases the Task List count' do
    valid_task_list.save
    expect { described_class.delete(valid_task_list) }.to change { described_class.all.count }.by(-1)
  end

  it 'updates task list name' do
    valid_task_list.save
    valid_task_list.name = 'New list name'
    expect(valid_task_list.name).to match('New list name')
  end

  it 'updates task list priority' do
    valid_task_list.save
    valid_task_list.priority = 'low'
    expect(valid_task_list.priority).to match('low')
  end

  it 'updates task list priority' do
    valid_task_list.save
    valid_task_list.color = '#333'
    expect(valid_task_list.color).to match('#333')
  end

  it 'destroys task list & decreseas count' do
    valid_task_list.save
    expect{ described_class.delete(valid_task_list) }.to change { described_class.all.count }.by(-1)
  end
end
