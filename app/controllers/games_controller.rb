class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column

  def index
    @games = GamesPresenter.apply_sort(Game.all, sort_column, sort_direction)
    #IDEA Add dates to sort and columns?
  end

  def show
    @guess = Guess.new
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      flash[:success] = "Game created successfully"
      redirect_to @game
    else
      render 'new'
    end
  end

  def destroy
    @game.destroy
    flash[:success] = "Game deleted successfully"
    redirect_to games_url
  end

  private

  def sort_column
    params[:sort] || "name"
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:word_to_guess, :number_of_lives, :player_id)
  end
end
