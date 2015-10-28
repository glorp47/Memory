class Card
attr_accessor :value, :face_up

  def initialize(value)
    @value = value
    @face_up = false
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def display
    return @value if @face_up
    return "_" if !@face_up
  end

  def to_s
    "#{@value} #{@face_up}"
  end

  def ==(other_card)
    @value == other_card.value
  end

end
