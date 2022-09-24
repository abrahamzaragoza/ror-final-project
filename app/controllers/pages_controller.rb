# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @plans = Plan.all
  end

  def about; end
end
