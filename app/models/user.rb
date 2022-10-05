# frozen_string_literal: true

class User < ApplicationRecord
  include AuthorizedPersona::Persona
  MAX_BOARDS = 10

  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :boards, foreign_key: :owner, dependent: :destroy, inverse_of: :owner
  has_many :tasks, foreign_key: :author, dependent: :destroy, inverse_of: :author
  has_many :tasks, through: :task_users, dependent: :destroy

  has_many :subordinates, class_name: 'User', foreign_key: 'manager_id'
  belongs_to :manager, class_name: 'User', optional: true

  authorization_tiers(
    user: 'User - limited access',
    manager: 'Manager - standard access',
    admin: 'Admin - all access'
  )

  validates :authorization_tier, inclusion: { in: authorization_tier_names }

  def can_create_board?
    boards.count < MAX_BOARDS
  end
end
