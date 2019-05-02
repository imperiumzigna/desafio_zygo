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

require 'rails_helper'

describe Drink do
  describe 'validations' do
    subject { drink }

    let(:drink) { FactoryBot.build :drink }

    it { expect { drink.name = nil }.to change { drink.valid? }.from(true).to(false) }
    it { expect { drink.description = nil }.to change { drink.valid? }.from(true).to(false) }
    it { expect { drink.image_url = nil }.to change { drink.valid? }.from(true).to(false) }
    it { expect { drink.rating_avg = 6 }.to change { drink.valid? }.from(true).to(false) }
    it { expect { drink.alcohol_level = -1 }.to change { drink.valid? }.from(true).to(false) }
    it { expect { drink.ibu = 11 }.to change { drink.valid? }.from(true).to(false) }
  end
end
