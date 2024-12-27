#!/usr/bin/env ruby

def substrings(word, dictionary)
  result = Hash.new(0)
  word = word.downcase

  # convert dictionary words to lowercase once
  dictionary = dictionary.map(&:downcase)

  dictionary.each do |dict_word|
   matches = word.scan(dict_word)
    result[dict_word] += matches.length if matches.length > 0
  end

  result
end

# Test cases
dictionary = %w[below down go going horn how howdy it i low own part partner sit]

# Test with single word
# puts "Testing with 'below':"
# puts substrings('below', dictionary)

# Test with multiple words
# puts "\nTesting with sentence:"
# puts substrings("Howdy partner, sit down! How's it going?", dictionary)

# get the script name from the full path
script_name = File.basename(__FILE__)

def show_usage(script_name)
  puts "Usage: ruby --jit #{script_name} word"
  puts "Example: ruby --jit #{script_name} 'below'"
  puts "\nNotes:"
  puts '- word should be enclosed in quotes if it contains spaces'
  exit(1)
end

# check if correct number of arguments are provided
show_usage(script_name) if ARGV.length != 1

input_string = String(ARGV[0])

puts substrings(input_string, dictionary)
