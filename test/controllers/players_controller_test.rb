require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get next_piece" do
    get :next_piece
    assert_response :success
  end

  test "should get hold_piece" do
    get :hold_piece
    assert_response :success
  end

  test "should get game_over" do
    get :game_over
    assert_response :success
  end

end
