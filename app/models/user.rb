# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :boards, foreign_key: :owner, dependent: :destroy, inverse_of: :owner
  has_many :tasks, foreign_key: :author, dependent: :destroy, inverse_of: :author
  has_many :tasks, through: :task_users, dependent: :destroy
end
