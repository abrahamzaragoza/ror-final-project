# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authorize!

  def index
    @plans = Plan.all
  end

  def about; end
end
