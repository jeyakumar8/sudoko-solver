class GameController < ApplicationController
  include GameHelper
  def mine
    @message = "welcome to SUDOKO solver"
  end

  def new_game
    @message = "SUDOKO Board"
    @post = Array.new(9){Array.new(9)}
  end

  def calculate
    @post = Array.new(9){Array.new(9)}
    @post, is_value = sudoko(params["@post"])
    array = @post.dup
    if is_value
      redirect_to mine_path(:param1 => array.to_json)
    else
      redirect_to incorrect_path
    end
  end

  def mine
    array = JSON.parse(params[:param1])
    solve_array(array)
    @post = array
    # render "mine"
  end

  def incorrect
  end
end
