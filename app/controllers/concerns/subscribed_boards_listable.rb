module SubscribedBoardsListable
  extend ActiveSupport::Concern

  included do
    before_action :list_boards_subscribed_ids
  end

  def list_boards_subscribed_ids
    @boards_subscribed_ids = user_signed_in? ? current_user.subscription_ids : []
  end

end
