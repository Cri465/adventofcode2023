require 'pry'
COLOURS = %i[red green blue].freeze

def raw_input
  file = File.open('input.txt')
  file.readlines.map(&:chomp)
end

def formatted_input
  raw_input.map do |x|
    { game_id(x) => split_draws(x) }
  end
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

def magic
  formatted_input.map { |x| min_amounts(x.values.flatten) }.map { |array| array.reduce(:merge) }
end

def min_amounts(game)
  COLOURS.map do |colour|
    { colour => game.max_by { |x| x[colour] || 0 }[colour] }
  end
end

def results_cubed
  magic.map { |x| x.values.inject(:*) }
end

p results_cubed.sum
