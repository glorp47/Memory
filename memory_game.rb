require './board'
require 'byebug'

class MemoryGame
  attr_accessor :board, :last_guess

  def initialize(board)
    @board = board
    @last_guess = nil
  end

  def play
    until won?
      sleep(2)
      system("clear")
      @board.render
      puts "Please input your card coordinates"
      guess = gets.chomp.split(", ").map(&:to_i)
      make_guess(guess) if valid_guess?(guess)
      puts " "
      @board.render
      puts "Please try to guess where the match is"
      guess = gets.chomp.split(", ").map(&:to_i)
      make_guess(guess) if valid_guess?(guess)
    end
    puts "YOU WON"
  end

  def make_guess(guess)
    guessed_card = @board.grid[guess[0]][guess[1]]
    p guessed_card
    if last_guess == nil
      guessed_card.reveal
      @last_guess = guess
    else
      second_guess(guessed_card)
    end
  end

  def second_guess(guessed_card)
    previous_guess = @board.grid[last_guess[0]][last_guess[1]]
    guessed_card.reveal
    if guessed_card == previous_guess
      puts "MATCH FOUND"
      @last_guess = nil
      previous_guess = nil
    else
      @board.render
      guessed_card.hide
      previous_guess.hide
      sleep(1)
      puts "NO MATCH"
      @last_guess = nil
      previous_guess = nil
    end
  end


  def valid_guess?(guess)
    guessed_card =  @board.grid[guess[0].to_i][guess[1].to_i]
    guessed_card.face_up == false && guess[0].to_i < @board.grid.length && guess[1].to_i < @board.grid.length
  end

  def won?
      @board.grid.each do |row|
        row.each do |cell|
          return false if !cell.face_up
        end
      end
      true
  end


end
