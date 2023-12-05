require 'pry'

def raw_input
  file = File.open('input.txt')
  file.readlines.map { |x| x.gsub("\n", '') }
end

def get_numbers_and_ranges(string)
  numbers = []
  string.scan(/\d+/) { |x| numbers << [x, $~.offset(0)[0]] }
  numbers.map do |number|
    first_index = [number[1] - 1, 0].max
    [number[0].to_i, first_index..number[1] + number[0].length]
  end
end

def relevent_characters_ind_line(line_number, range)
  raw_input[line_number]&.[](range)
end

def all_relevent_characters(line_number, range)
  relevent_lines = [[line_number - 1, 0].max, line_number, line_number + 1]
  relevent_lines.to_h do |line_number|
    [line_number, relevent_characters_ind_line(line_number, range)]
  end
end

def find_asterik_coords(array, range)
  return nil unless array[1]&.include?('*')

  [array[0], range.first + array[1].index('*')]
end
numbers_attached_to_asteriks = {}
raw_input.each_with_index.map do |line, index|
  get_numbers_and_ranges(line).each do |num|
    all_relevent_characters(index, num[1]).each do |chars|
      key = find_asterik_coords(chars, num[1])
      next if key.nil?

      numbers_attached_to_asteriks[key] ||= []
      numbers_attached_to_asteriks[key] << num[0]
    end
  end
end
numbers_attached_to_asteriks.select! { |_k, v| v.length == 2 }.transform_values! { |v| v.inject(:*) }
p numbers_attached_to_asteriks.values.flatten.sum
