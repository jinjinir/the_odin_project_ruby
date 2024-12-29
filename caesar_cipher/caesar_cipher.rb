#!/usr/bin/env ruby
# frozen_string_literal: true

def caesar_cipher(string, shift)
  # handle negative shifts and shifts > 26
  shift %= 26

  # convert string to array of characters and map each one
  string.chars.map do |char|
    # check if character is a letter
    if char.match?(/[A-Za-z]/)
      # get ascii value
      ascii = char.ord

      # handle uppercase letters (65-90 in ascii)
      new_ascii = ascii + shift
      new_ascii = if ascii.between?(65, 90)
                    new_ascii > 90 ? (new_ascii - 26) : new_ascii
                  # handle lowercase letters (97-122 in ascii)
                  else
                    new_ascii > 122 ? (new_ascii - 26) : new_ascii
                  end

      # convert back to character
      new_ascii.chr
    else
      # return non-letter characters unchanged
      char
    end
  end.join
end

# get the script name from the full path
script_name = File.basename(__FILE__)

def show_usage(script_name)
  puts "Usage: ruby --jit #{script_name} 'string' shift _number"
  puts "Example: ruby --jit #{script_name} 'Hello, World!' 3"
  puts "\nNotes:"
  puts '- shift_number must be an integer'
  puts '- string should be enclosed in quotes if it contains spaces'
  exit(1)
end

# check if correct number of arguments are provided
show_usage(script_name) if ARGV.length != 2

# get input string and shift from command line arguments
input_string = ARGV[0]

# validate shift parameter
begin
  shift = Integer(ARGV[1])
rescue ArgumentError
  puts "Error: '#{ARGV[1]}' is not a valid integer"
  show_usage(script_name)
end

# print the result
puts "Original text: #{input_string}"
puts "Shift amount: #{shift}"
puts "Encrypted text: #{caesar_cipher(input_string, shift)}"
