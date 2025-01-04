#!/usr/bin/env ruby
# frozen_string_literal: true
require 'csv'

puts 'Event Manager Initialized!'

def clean_zipcode(zipcode)
  zipcode = zipcode&.to_s || ''  # &. safe navigation with default return value
  
  if zipcode.length < 5
    zipcode = zipcode.rjust(5, '0')
  elsif zipcode.length > 5
    zipcode = zipcode[0..4]
  else
    zipcode
  end
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]  # assign header as index value
  zipcode = clean_zipcode(row[:zipcode])

  puts "#{name} #{zipcode}"
end
