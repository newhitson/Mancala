require 'byebug'
class Board
  attr_accessor :cups, :name1, :name2

  def initialize(name1, name2)
    @cups = [[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
    place_stones
    @name1 = name1
    @name2 = name2

  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup,i|
      next if i == 6 || i == 13
      4.times do
        cup << :stone
      end
    end

  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos > 14
    raise "Invalid starting cup" if start_pos < 1


  end

  def make_move(start_pos, current_player_name)
    current_player_name == @name1 ? bad_cup = 13 : bad_cup = 6
    current_player_name == @name1 ? good_cup = 6 : good_cup = 13
    idx = start_pos
    until @cups[start_pos].empty?
        idx += 1
        idx = 0 if idx == 14
        @cups[idx] << @cups[start_pos].pop unless idx == bad_cup

    end
    render

    next_turn(idx,good_cup)
  end

  def next_turn(ending_cup_idx,good_cup)
    # helper method to determine what #make_move returns
    return :prompt if ending_cup_idx == good_cup
    return :switch if @cups[ending_cup_idx].length == 1
    return ending_cup_idx if @cups[ending_cup_idx].length > 1
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    top = @cups[7..12].all? do |cup|
      cup.length == 0
    end
    bottom = @cups[1..6].all? do |cup|
      cup.length == 0
    end
    return true if top || bottom
    false
  end

  def winner
    return :draw if @cups[6] == @cups[13]
    @cups[6].length > @cups[13].length ? @name1 : @name2
  end
end
