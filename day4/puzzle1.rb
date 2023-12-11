require 'pry'

def raw_input
  file = File.open('test_input.txt')
  file.readlines.map { |x| x.gsub("\n", '') }
end

second_bits = raw_input.map { |z| z.split('|')[1].split }
first_bits = raw_input.map { |z| z[/:(.*?)\|/, 1].split }

hello = first_bits.each_with_index.map do |card, index|
  binding.pry
  overlap = (card & second_bits[index]).length - 1
  1 * (2**overlap).floor
end

p hello.sum
