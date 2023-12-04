# frozen_string_literal: true

require 'pry'

class String
  def contains_symbol?
    count('.') != length
  end
end

def raw_input
  file = File.open('test_input.txt')
  file.readlines.map { |x| x.gsub("\n", '') }
end

def get_numbers_and_ranges(string)
  numbers = []
  string.scan(/\d+/) { |x| numbers << [x, $~.offset(0)[0]] }
  numbers.map do |number|
    { number[0].to_i => [number[1] - 1, 0].max..number[1] + number.length }
  end
end

def relevent_characters_ind_line(line_number, range)
  raw_input[line_number]&.[](range)
end

def all_relevent_characters(line_number, range)
  correct_line_number = [line_number, 0].max
  [relevent_characters_ind_line(correct_line_number - 1, range), relevent_characters_ind_line(correct_line_number, range),
   relevent_characters_ind_line(correct_line_number + 1, range)].join.gsub(/\d/, '')
end

def valid_numbers(line_number, line_hashes)
  valid_numbers = []
  line_hashes.each do |_line_hash|
    valid_numbers << number if all_relevent_characters(line_number, range).contains_symbol?
  end
  valid_numbers
end

def total
  running_total = 0
  raw_input.each_with_index do |line, index|
    binding.pry
    running_total += valid_numbers(index, get_numbers_and_ranges(line)).sum
  end
  running_total
end

p total
