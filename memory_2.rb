require './board'
require 'byebug'
require './players'

class MemoryGame
  attr_accessor :board, :last_guess, :player

  def initialize(board, player)
    @board = board
    @player = player
    @last_guess = nil
    @player.get_grid_size(@board.length)
  end

  def play
    until won?
      sleep(2)
      system("clear")
      @board.render
      guess = nil
      until valid_guess?(guess) #become own method
        guess = @player.prompt(@last_guess) #not instance varible
      end
      make_guess(guess)
      puts " "
      @board.render
      until valid_guess?(guess)
        guess = @player.prompt(@last_guess)
      end
      make_guess(guess) if valid_guess?(guess)
    end
    puts "YOU WON"
    @board.render
  end

  def make_guess(guess)
    guessed_card = @board[guess[0]][guess[1]] # define board[]
    @player.receive_revealed_card(guess, guessed_card.value)
    if @last_guess == nil
      guessed_card.reveal
      @last_guess = guess
    else
      second_guess(guessed_card)
    end
  end

  def second_guess(guessed_card)
    previous_guess = @board[@last_guess[0]][@last_guess[1]]
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
#

  def valid_guess?(guess)
    if guess.nil?
      false
    elsif guess[0].to_i >= @board.length || guess[1].to_i >= @board.length
      puts "Alert: Invalid Guess"
      false
    else
      guessed_card =  @board[guess[0].to_i][guess[1].to_i]
      guessed_card.face_up == false
    end
  end

  def won?
      board.grid.each do |row|
        row.each do |cell|
          return false if !cell.face_up
        end
      end
      true
  end


end
