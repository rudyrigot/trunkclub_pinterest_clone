class FeedsController < ApplicationController
  def home
    @most_recent_pins_on_subscribed_boards = (!user_signed_in? || @boards_subscribed_ids.count == 0) ? [] : Pin.most_recent_on_boards(@boards_subscribed_ids)
    @most_recent_pins = Pin.most_recent
    @random_boards = Board.random
  end
end
