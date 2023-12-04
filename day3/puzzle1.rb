# frozen_string_literal: true

require 'pry'

class String
  def contains_symbol?
    count('.') != length
  end
end

def raw_input
  file = File.open('input.txt')
  file.readlines.map { |x| x.gsub("\n", '') }
end

def get_numbers_and_ranges(string)
  numbers = []
  string.scan(/\d+/) { |x| numbers << [x, $~.offset(0)[0]] }
  numbers.map do |number|
    first_index = [number[1] - 1, 0].max
    { number[0].to_i => first_index..number[1] + number[0].length }
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
  line_hashes.each do |number|
    valid_numbers << number.keys.first if all_relevent_characters(line_number, number.values.first).contains_symbol?
  end
  valid_numbers
end

def total
  running_total = 0
  raw_input.each_with_index do |line, index|
    running_total += valid_numbers(index, get_numbers_and_ranges(line)).sum
  end
  running_total
end

p total
