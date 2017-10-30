class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "-----------"
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "-----------"
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player = "X")
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |space|
      if space != " "
        counter += 1
      end
    end
    counter
  end

  def current_player
    if turn_count % 2 ==0
      "X"
    else
      "O"
    end
  end

  def won?
    WIN_COMBINATIONS.detect do |win_combo|
      position_taken?(win_combo[0]) && (@board[win_combo[0]] == @board[win_combo[1]]) && (@board[win_combo[1]] == @board[win_combo[2]])
    end
  end

  def full?
    WIN_COMBINATIONS.all? do |tokens|
      position_taken?(tokens[0])
    end
  end

  def draw?
    if !won? && full?
      return true
    end
  end

  def over?
    won? || draw?
  end

  def winner
    if won? == nil
      return nil
    else
      return @board[won?[1]]
    end
  end

  def play
    while over? == false
      turn
    end

    if draw? == true
      puts "Cat's Game!"
    end

    if won? != nil
      puts "Congradulations! #{winner}!"
    end
  end
end
