# frozen_string_literal: true

class DrinksController < ApplicationController
  def index
    if params[:search]
      @search_results = Drink.where('name ILIKE ?', "%#{params[:search]}%")
                             .paginate(page: params[:page])
      respond_to do |format|
        format.js { render partial: 'search-results' }
      end
    else
      @drinks = Drink.paginate(page: params[:page])
    end
  end

  def advanced
    if params[:advanced_search]
      @search_results = Drink
                        .search_by_name_or_description(params[:advanced_search])
                        .paginate(page: params[:page])
      respond_to do |format|
        format.js { render partial: 'search-results' }
      end
    else
      @drinks = Drink.paginate(page: params[:page])
    end
  end

  def recommend
    suggest = Recommendation.new(recommendation_params,
                                 [0, 100, 0, 10, 0, 4]).make
    @search_results = Drink.where("rating_avg >= #{suggest.sample}")
                           .order('rating_avg DESC')
                           .paginate(page: params[:page])
    respond_to do |format|
      format.js { render partial: 'search-results' }
    end
  end

  private

  def recommendation_params
    params.permit(:alcohol_level, :ibu, :temperature).values.map(&:to_f)
  end
end
