#!/usr/bin/env ruby
# frozen_string_literal: true

class TicTacToe
  def initialize
    @board = Array.new(3) { Array.new(3, " ") } # Creates a 3x3 board with empty spaces
    @current_player = "X" # The first player is "X"
  end

  def play
    loop do
      display_board
      player_turn
      if winner?
        display_board
        puts "Player #{@current_player} wins!"
        break
      elsif draw?
        display_board
        puts "It's a draw!"
        break
      end
      switch_player
    end
  end

  private

  def display_board
    puts "\n  1 2 3"
    @board.each_with_index do |row, index|
      puts "#{index + 1} #{row.join('|')}"
      puts "  -----" unless index == 2
    end
  end

  def player_turn
    puts "\nPlayer #{@current_player}, enter your move (row and column): "
    loop do
      move = gets.chomp.split.map(&:to_i) # Takes input as "row col" and converts it to integers
      if valid_move?(move)
        row, col = move.map { |n| n - 1 } # Convert to zero-based index
        @board[row][col] = @current_player
        break
      else
        puts "Invalid move. Enter a valid row and column (1-3): "
      end
    end
  end

  def valid_move?(move)
    return false unless move.size == 2 # Ensure two numbers are entered

    row, col = move.map { |n| n - 1 } # Convert to zero-based index
    row.between?(0, 2) && col.between?(0, 2) && @board[row][col] == " "
  end

  def winner?
    # Check rows, columns, and diagonals for a win
    lines = @board + @board.transpose + diagonals
    lines.any? { |line| line.uniq.size == 1 && line.first != " " }
  end

  def diagonals
    [
      [@board[0][0], @board[1][1], @board[2][2]],
      [@board[0][2], @board[1][1], @board[2][0]]
    ]
  end

  def draw?
    @board.flatten.none? { |cell| cell == " " }
  end

  def switch_player
    @current_player = @current_player == "X" ? "O" : "X"
  end
end

# Start the game
TicTacToe.new.play
