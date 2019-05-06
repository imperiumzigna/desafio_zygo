# frozen_string_literal: true

# == Schema Information
#
# Table name: drinks
#
#  id              :bigint           not null, primary key
#  name            :string
#  description     :string
#  image_url       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  alcohol_level   :integer
#  distilled       :boolean
#  temperature     :integer
#  base_ingredient :string
#  origin          :string
#  ibu             :integer
#  drinkware       :string
#  rating_avg      :decimal(, )
#
class Drink < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_name_or_description, against: %i[name description], using: {
    tsearch: { prefix: true }
  }

  validates :name, :description, :image_url, presence: true
  validates :rating_avg, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
  }
  validates :alcohol_level, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }
  # Bitterness level
  validates :ibu, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10
  }

  enum temperature: %i[
    hot
    warm
    ambient
    cold
    extra_cold
  ]

  self.per_page = 10
end
