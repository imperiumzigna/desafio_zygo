# frozen_string_literal: true

class DrinksController < ApplicationController
  def index
    @drinks = Drink.paginate(page: params[:page])
  end
end
