require 'pry'

def raw_input
  file = File.open('test_input.txt')
  file.readlines.map { |x| x.gsub("\n", '') }
end

second_bits = raw_input.map { |z| z.split('|')[1].split }
first_bits = raw_input.map { |z| z[/:(.*?)\|/, 1].split }

parsed_input = raw_input.map do |line|
  { id: line[/\d+/], winning_numbers: line[/:(.*?)\|/, 1].split, numbers_in_play: line.split('|')[1].split }
end

number_of_cards = {}
208.times { |x| number_of_cards[x] = 1 }
parsed_input.map do |line|
  number_of_cards[line]
end

binding.pry
