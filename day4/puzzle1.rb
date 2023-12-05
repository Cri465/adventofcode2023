require 'pry'

def raw_input
  file = File.open('input.txt')
  file.readlines.map { |x| x.gsub("\n", '') }
end

second_bits = raw_input.map { |z| z.split('|')[1].split }
first_bits = raw_input.map { |z| z[/:(.*?)\|/, 1].split }

hello = first_bits.each_with_index.map do |card, index|
  1 * (2**((card & second_bits[index]).length - 1)).floor
end

p hello.sum
