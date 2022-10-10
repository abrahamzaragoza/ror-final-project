# frozen_string_literal: true

class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year

  belongs_to :user

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i + 1} - #{name}", i + 1] }
  end

  def self.year_options
    (Time.zone.today.year..(Time.zone.today.year + 10)).to_a
  end
end
