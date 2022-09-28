# frozen_string_literal: true

require 'rails_helper'
require 'shared/shared_board_context.rb'

RSpec.describe Board, type: :model do
  let(:valid_board) do
    described_class.new(
      title: 'Board title',
      visibility: 'public'
    )
  end

  context 'with a valid board, create board' do
    it 'saves & increment the Board count' do
      expect { valid_board.save }.to change { described_class.all.count }.by(1)
    end

    it 'must have a valid visibility' do
      expect(valid_board.visibility).to eq('public').or eq('private')
    end
  end

  context 'with invalid params, create board' do
    it "doesn't save a board without a title" do
      valid_board.title = ''
      expect(valid_board.save).to be_falsy
    end

    it "doesn't save a board with a title > 80" do
      valid_board.title = 'a' * 81
      expect(valid_board.save).to be_falsy
    end
  end

  context 'with previusly saved board, update board' do
    before do
      valid_board.save
    end

    it 'updates board title' do
      valid_board.update(title: 'New Title')
      expect(valid_board.title).to match('New Title')
    end

    it 'updates board visibility' do
      valid_board.update(visibility: 'private')
      expect(valid_board.visibility).to match('private')
    end
  end

  context 'with previusly saved board, destroy board' do
    before do
      valid_board.save
    end

    it 'destroys and decrease board count' do
      expect { described_class.delete(valid_board) }.to change { described_class.all.count }.by(-1)
    end
  end

  context 'with baoard associated with task list & tasks' do
    include_context "Board's context"

    before do
      valid_board.save
      valid_task_list.save
      valid_task.save
    end

    it 'board count should be one' do
      expect(described_class.all.count).to eq(1)
    end

    it 'destroys board with all associated objects - board count to be 0' do
      expect{ valid_board.destroy }.to change { described_class.all.count }.by(-1)
    end

    it 'destroys board with all associated objects - task lists count to be 0' do
      expect{ valid_board.destroy }.to change { TaskList.all.count }.by(-1)
    end

    it 'destroys board with all associated objects - tasks count to be 0' do
      expect{ valid_board.destroy }.to change { Task.all.count }.by(-1)
    end
  end
end
