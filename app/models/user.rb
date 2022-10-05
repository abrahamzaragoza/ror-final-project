# frozen_string_literal: true

class User < ApplicationRecord
  include AuthorizedPersona::Persona

  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :boards, foreign_key: :owner, dependent: :destroy, inverse_of: :owner
  has_many :tasks, foreign_key: :author, dependent: :destroy, inverse_of: :author
  has_many :tasks, through: :task_users, dependent: :destroy

  authorization_tiers(
    user: 'User - limited access',
    manager: 'Manager - standard access',
    admin: 'Admin - all access'
  )

  validates :authorization_tier, inclusion: { in: authorization_tier_names }
end
