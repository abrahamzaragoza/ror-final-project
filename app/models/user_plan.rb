# frozen_string_literal: true

class UserPlan < ApplicationRecord
  enum status: { incomplete: 0, incomplete_expired: 1, trialing: 2, active: 3, past_due: 4, canceled: 5, unpaid: 6 }

  belongs_to :user
  belongs_to :plan
end
