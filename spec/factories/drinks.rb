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

FactoryBot.define do
  factory :drink do
    name 'Drink A'
    image_url 'https://example.com/image.jpg'
    description 'A drink that has a lot of water'
    rating_avg 1
    alcohol_level 1
    ibu 1
    temperature :hot
  end
end
