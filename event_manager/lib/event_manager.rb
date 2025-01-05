#!/usr/bin/env ruby
# frozen_string_literal: true
require 'csv'

puts 'Event Manager Initialized!'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
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
