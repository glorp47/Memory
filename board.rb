  require './card'
  require 'byebug'

class Board



  attr_accessor :grid
  FACE_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]

  def initialize(size = 4)
    @grid = Array.new(size) {Array.new(size)}
  end

  def [](num)
    @grid[num]
  end

  def length
    @grid.length
  end

  def populate
    cards =[]
    ((grid.length**2) / 2).times do
      this_face = Card.new(FACE_VALUES.sample)
      while cards.include?(this_face)
        this_face = Card.new(FACE_VALUES.sample)
      end
      cards << this_face
      cards << this_face.dup
    end
    cards.shuffle!
    card_index = 0
    @grid.each_with_index do |row, i|
      row.each_with_index do |_, j|
        @grid[i][j] = cards[card_index]
        card_index += 1
      end
    end
  end

  def render
    puts "GRID"
    0.upto(@grid.length-1) do |i|
      print "  " if i == 0
      print "|#{i}|"
    end
    puts ""
    @grid.each_with_index do |row, idx|
      row.each_with_index do |cell, idx2|
        print "#{idx} " if idx2 == 0
        print "|#{cell.display}|"
      end
      puts ""
    end


  end



end
