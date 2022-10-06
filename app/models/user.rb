# frozen_string_literal: true

class User < ApplicationRecord
  include AuthorizedPersona::Persona
  MAX_BOARDS = 10

  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :boards, foreign_key: :owner, dependent: :destroy, inverse_of: :owner
  has_many :tasks, foreign_key: :author, dependent: :destroy, inverse_of: :author
  has_many :task_users, dependent: :destroy
  has_many :task, through: :task_users, dependent: :destroy

  has_many :subordinates, class_name: 'User', foreign_key: 'manager_id', dependent: :destroy, inverse_of: :manager
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

  def manager?
    authorization_tier.match?('manager')
  end

  def return_manager
    manager
  end

  def return_manager_boards
    if manager?
      Board.where(owner: id)
    else
      Board.where(owner: manager_id)
    end
  end

  def return_manager_team
    if manager?
      subordinates
    else
      User.find(manager_id).subordinates
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
