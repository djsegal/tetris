class PlayersController < ApplicationController
  before_action :set_game
  before_action :set_player

  def next_piece
    @player.current_piece.get_next_piece
    render 'games/show'
    return
  end

  def hold_piece
    @player.hold_piece.hold_current_piece
    render 'games/show'
    return
  end

  def game_over
    @player_id = @player.ordering_index
  end

  private

    def set_game
      @game = Game.find(params[:game_id])
    end

    def set_player
      @player = @game.players.find_by(ordering_index: params[:player_index])
    end

end
