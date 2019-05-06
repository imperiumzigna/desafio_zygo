# frozen_string_literal: true

require 'rails_helper'

context 'when valid attributes' do
  it 'sets valid feature attributes' do
    preference = Recommendation.new([1], [0, 5])
    expect(preference.features).to eq [1.0]
  end

  it 'sets valid range attributes' do
    preference = Recommendation.new([1], [0, 5])
    expect(preference.min_max).to eq [0.0, 5.0]
  end

  it 'sets slices of range' do
    preference = Recommendation.new([1], [0, 5])
    expect(preference.slices).to eq [[0.0, 5.0]]
  end
end

context 'when invalid attributes' do
  it 'creates invalid features' do
    expect { Recommendation.new([1, 2], []) }
      .to raise_error(ArgumentError, 'Cannot be empty')
  end

  it 'creates invalid ranges' do
    expect { Recommendation.new([], [1, 2]) }
      .to raise_error(ArgumentError, 'Cannot be empty')
  end
end

context 'when invalid data type' do
  it 'check features type' do
    expect { Recommendation.new('aaa', [1, 2]) }
      .to raise_error(ArgumentError, 'Must be array')
  end

  it 'check range type' do
    expect { Recommendation.new([1, 2], 'bbb') }
      .to raise_error(ArgumentError, 'Must be array')
  end

  it 'check base ranking type' do
    expect { Recommendation.new([4], [0, 10], 'ccc') }
      .to raise_error(ArgumentError, 'Must be array')
  end
end

context 'when invalid sizes' do
  it 'feature size' do
    expect { Recommendation.new([1, 2], [0, 1]) }
      .to raise_error(ArgumentError, 'Invalid size')
  end

  it 'range size' do
    expect { Recommendation.new([1, 2], [0, 1]) }
      .to raise_error(ArgumentError, 'Invalid size')
  end
end

context 'when finished setup' do
  it 'generates normalized values' do
    preference = Recommendation.new([1], [0, 5])
    expect(preference.make).to eq [1.0]
  end
  it 'normalize multiple values' do
    preference = Recommendation.new([1, 3, 0, 1], [0, 5, 0, 10, 0, 5, 0, 5])
    expect(preference.make).to eq [1.0, 1.5, 0.0, 1.0]
  end
end

describe 'finished setup' do
  context 'when change base ranking' do
    it 'generates normalized values' do
      preference = Recommendation.new([4], [0, 5], [0, 10])
      expect(preference.make).to eq [8.0]
    end

    it 'normalize multiple values' do
      preference = Recommendation.new([1, 3, 0, 1],
                                      [0, 5, 0, 10, 0, 5, 0, 5],
                                      [0, 10])
      expect(preference.make).to eq [2.0, 3.0, 0.0, 2.0]
    end
  end
end
