class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column

  def index
    games = Game.all
    @games = apply_sort(games, sort_column, sort_direction)
  end

  def show
    @guess = Guess.new
  end

  def new
    @game = Game.new
  end

  def edit
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

  def update
    if @game.update(game_params)
      flash[:success] = "Game updated successfully"
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    @game.destroy
    flash[:success] = "Game deleted successfully"
    redirect_to games_url
  end

  private

  def sort_column
    params[:sort] ? params[:sort] : "player.name"
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params[:game].permit(:word_to_guess, :number_of_lives, :player_id)
  end
end