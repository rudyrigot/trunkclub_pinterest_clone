class Pin < ActiveRecord::Base
  belongs_to :board

  validates :title, :link, :board_id, presence: true

  def can_be_edited_by?(user)
    user.admin? || user == self.board.user
  end
end
