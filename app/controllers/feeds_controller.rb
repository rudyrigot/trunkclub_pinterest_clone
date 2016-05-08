class FeedsController < ApplicationController
  def home
    @most_recent_pins = Pin.includes(board: :user).order(created_at: :desc).limit(30)
    @random_boards = Board.includes(:user).order("RANDOM()").limit(10)
  end
end
