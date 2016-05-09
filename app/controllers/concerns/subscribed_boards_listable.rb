module SubscribedBoardsListable
  extend ActiveSupport::Concern

  included do
    before_action :list_boards_subscribed
  end

  def list_boards_subscribed
    @boards_subscribed = user_signed_in? ? current_user.subscription_ids : []
  end

end
