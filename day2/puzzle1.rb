require 'active_support'
require 'pry'

CUBE_LIMITS = { red: 12, green: 13, blue: 14 }.freeze

def raw_input
  file = File.open('input.txt')
  file.readlines.map(&:chomp)
end

def formatted_input
  raw_input.map do |x|
    { game_id(x) => split_draws(x).map { |draw| draw_valid?(draw) }.flatten }.reject { |_, v| v.include?(false) }
  end.reject(&:empty?)
end

def merged_results
  formatted_input.reduce(:merge)
end

def game_id(string)
  string.match(/\d+/)[0].to_i
end

def split_draws(string)
  draws = string.split(':')[1].chomp
  draws.split(';').map do |x|
    x.split(',').map { |z| z.split.reverse }.to_h.transform_values(&:to_i).transform_keys(&:to_sym)
  end
end

def draw_valid?(hash)
  hash.map { |k, v| v <= CUBE_LIMITS[k] }
end

p merged_results.keys.sum
