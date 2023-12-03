require 'pry'
require 'activesupport'

def raw_input
  file = File.open('input.txt')
  file.readlines.map do |line|
    line.chomp
  end
end

def puzzle1
  input = raw_input
  puzzle_data = input.map do |line|
    full_line = line.gsub(/[^0-9]/, '')
    "#{full_line[0]}#{full_line[-1]}".to_i
  end
  total = puzzle_data.sum
  p total
end

def puzzle2
  nums =
    { 'one' => 'o1e',
      'two' => 't2o',
      'three' => 't3e',
      'four' => 'f4r',
      'five' => 'f5e',
      'six' => 's6x',
      'seven' => 's7n',
      'eight' => 'e8t',
      'nine' => 'n9e' }

  input = raw_input
  puzzle_data = input.map do |line|
    full_line = line.gsub(Regexp.union(nums.keys), nums).gsub(Regexp.union(nums.keys), nums).gsub(/[^0-9]/, '')
    "#{full_line[0]}#{full_line[-1]}".to_i
  end
  p puzzle_data.sum
end

# puzzle1
puzzle2
