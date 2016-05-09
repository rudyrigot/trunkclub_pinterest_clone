class Pin < ActiveRecord::Base
  belongs_to :board

  validates :title, :link, :board_id, presence: true
  validates :link, format: { with: /\A\s*https?:\/\//, message: "must be a valid URL (must start with http:// or https://)", allow_blank: true }

  scope :most_recent, -> { includes(board: :user).order(created_at: :desc).limit(24) }
  scope :most_recent_on_boards, ->(board_ids) { most_recent.where(board_id: board_ids) }

  def can_be_edited_by?(user)
    user.admin? || user == self.board.user
  end
end
