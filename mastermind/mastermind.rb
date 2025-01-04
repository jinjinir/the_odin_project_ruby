#!/usr/bin/env ruby
# frozen_string_literal: true

class Mastermind
  COLORS = ['R', 'G', 'B', 'Y', 'W', 'O']  # Red, Green, Blue, Yellow, White, Orange
  CODE_LENGTH = 4
  MAX_TURNS = 12

  def initialize
    @secret_code = generate_secret_code
    @current_turn = 1
  end

  def generate_secret_code
    # Randomly select 4 colors (allowing duplicates)
    Array.new(CODE_LENGTH) { COLORS.sample }
  end

  def get_player_guess
    loop do
      puts "\nAvailable colors: #{COLORS.join(', ')}"
      print "Turn #{@current_turn}/#{MAX_TURNS} - Enter your guess (4 colors, space-separated): "
      
      guess = gets.chomp.upcase.split
      
      if guess.length != CODE_LENGTH
        puts "Please enter exactly #{CODE_LENGTH} colors."
        next
      end
      
      unless guess.all? { |color| COLORS.include?(color) }
        puts "Invalid colors! Use only the available colors."
        next
      end
      
      return guess
    end
  end

  def evaluate_guess(guess)
    exact_matches = 0
    partial_matches = 0
    
    # Create copies to handle partial matches
    secret_copy = @secret_code.dup
    guess_copy = guess.dup
    
    # First, find exact matches
    CODE_LENGTH.times do |i|
      if guess[i] == @secret_code[i]
        exact_matches += 1
        secret_copy[i] = nil
        guess_copy[i] = nil
      end
    end
    
    # Then, find partial matches
    CODE_LENGTH.times do |i|
      next if guess_copy[i].nil?
      if index = secret_copy.index(guess_copy[i])
        partial_matches += 1
        secret_copy[index] = nil
      end
    end
    
    [exact_matches, partial_matches]
  end

  def play_game
    puts "\nWelcome to Mastermind!"
    puts "Try to guess the #{CODE_LENGTH}-color code. You have #{MAX_TURNS} turns."
    puts "After each guess, you'll get feedback:"
    puts "✓ = correct color in correct position"
    puts "◯ = correct color in wrong position"
    
    while @current_turn <= MAX_TURNS
      guess = get_player_guess
      exact_matches, partial_matches = evaluate_guess(guess)
      
      # Display feedback
      feedback = "✓ " * exact_matches + "◯ " * partial_matches
      puts "Feedback: #{feedback}"
      
      # Check for win
      if exact_matches == CODE_LENGTH
        puts "\nCongratulations! You cracked the code in #{@current_turn} turns!"
        puts "The secret code was: #{@secret_code.join(' ')}"
        return true
      end
      
      @current_turn += 1
    end
    
    # Game over - no more turns
    puts "\nGame Over! You've run out of turns."
    puts "The secret code was: #{@secret_code.join(' ')}"
    false
  end
end

# Start the game
game = Mastermind.new
game.play_game
