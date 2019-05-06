# frozen_string_literal: true

# Recommendation class
class Recommendation
  attr_reader :features, :min_max, :slices,
              :normalized, :resized, :base_rank

  # Converts the object into textual markup given a specific format.
  #
  # @param preferences [Array]
  # @param range [Array]
  # @param base_rank [Array]
  #
  def initialize(preferences = [], range = [], base_rank = [0, 5])
    message = validate?(preferences, range, base_rank)
    raise ArgumentError, message if message

    @features = preferences.map(&:to_f)
    @min_max = range.map(&:to_f)
    @slices = min_max.each_slice(2).to_a
    @base_rank = base_rank
  end

  def make
    normalization
    resize
  end

  private

  def normalization
    @normalized = features.collect.with_index do |feature, index|
      norm(feature, slices[index][0], slices[index][1])
    end
  end

  def resize
    @resized = normalized.collect do |normal|
      scale(normal, base_rank[0], base_rank[1])
    end
  end

  def norm(value, min, max)
    (value - min) / (max - min)
  end

  def scale(value, min, max)
    value * (max - min) + min
  end

  def validate?(inputs, input_range, base_rank)
    return 'Must be array' if valid_type?(inputs, input_range, base_rank)
    return 'Cannot be empty' if valid_size?(inputs, input_range, base_rank)
    return 'Invalid size' if valid_range?(inputs, input_range)

    false
  end

  def valid_type?(inputs, input_range, base_rank)
    !inputs.is_a?(Array) || !input_range.is_a?(Array) || !base_rank.is_a?(Array)
  end

  def valid_size?(inputs, input_range, base_rank)
    inputs.empty? || input_range.empty? || base_rank.empty?
  end

  def valid_range?(inputs, input_range)
    inputs.size * 2 == input_range.size * 2
  end
end
