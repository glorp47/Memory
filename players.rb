require './board'

class HumanPlayer
  attr_accessor :name, :grid_size

  def initialize(name)
    @name = name
    @grid_size = nil
  end

  def prompt(last_guess)
    if last_guess.nil?
      puts "Pick your first card"
    else
      puts "Pick your second card"
    end
    get_input
  end

  def get_grid_size(size)

  end

  def get_input
    guess = gets.chomp.split(", ").map(&:to_i)
  end

  def receive_revealed_card(coordinates, value)
  end

end


class ComputerPlayer
  attr_accessor :name, :known_cards, :matched_cards, :grid_size

  def initialize(name)
    @name = name
    @known_cards = {}
    @matched_cards_queue = []
    @grid_size = nil
  end

  def get_grid_size(size)
    @grid_size = size
  end

  def prompt(last_guess)
    if last_guess.nil?
      get_input
    else
      get_input
    end
  end

  def get_input()

    if match_known?
      pick_match
    else
      random_pick = make_random_pick
      while known_cards.has_key?(random_pick)
        random_pick = make_random_pick
      end
      random_pick
  end
end

  def pick_match
    pick = @matched_cards_queue[0]
    @matched_cards_queue = @matched_cards_queue.drop(1)
    pick
  end

  def make_random_pick
    [(0...@grid_size).to_a.sample, (0...@grid_size).to_a.sample]
  end

  def match_known?
    if @matched_cards_queue[0] != nil
      return true
    else
      false
    end
  end

  def receive_revealed_card(coordinates, value)
    if !@known_cards.has_key?(coordinates)
      @known_cards[coordinates] = value
    end
    if @known_cards.select { |k, v| v == value}.size == 2
      @known_cards.each {|k, v| @matched_cards_queue << k if value == v }

    end
    @matched_cards_queue.uniq!
  end


end
