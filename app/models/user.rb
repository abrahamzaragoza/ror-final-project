# frozen_string_literal: true

class User < ApplicationRecord
  include AuthorizedPersona::Persona
  MAX_BOARDS = 10

  # separate these. look into the following link for
  # proper ordering of macros: https://github.com/rubocop/rails-style-guide#macro-style-methods 
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :boards, foreign_key: :owner, dependent: :destroy, inverse_of: :owner
  has_many :tasks, foreign_key: :author, dependent: :destroy, inverse_of: :author
  has_many :task_users, dependent: :destroy
  has_many :task, through: :task_users, dependent: :destroy
  has_many :subordinates, class_name: 'User', foreign_key: 'manager_id', dependent: :destroy, inverse_of: :manager
  belongs_to :manager, class_name: 'User', optional: true
  has_one :payment, dependent: :destroy
  has_one :user_plan, dependent: :destroy
  alias_attribute :plan, :user_plan
  after_create :add_manager_id

  authorization_tiers(
    user: 'User - limited access',
    manager: 'Manager - standard access',
    admin: 'Admin - all access'
  )

  validates :authorization_tier, inclusion: { in: authorization_tier_names }

  def can_create_board? # again, this could have been a validation
    boards.count < MAX_BOARDS
  end

  def manager?
    authorization_tier.match?('manager') # counted
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

  def return_manager_team # return is a protected word
    # in the programming lingo. avoid to use them in 
    # the methods namings. could have been only 
    # managers_team. and that would have been more ruby
    if manager?
      subordinates
    else
      # no need to do this, could have chained
      # manager.subordinates, since manager returns
      # the manager itself
      User.find(manager_id).subordinates
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def add_manager_id
    if invited_by_id.present?
      update(manager_id: invited_by_id)
    end
  end
end
