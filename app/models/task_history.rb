# frozen_string_literal: true

class TaskHistory < ApplicationRecord
  belongs_to :task
end
