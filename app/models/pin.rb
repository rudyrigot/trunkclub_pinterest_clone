class Pin < ActiveRecord::Base
  belongs_to :board

  validates :title, :link, :board_id, presence: true
  validates :link, format: { with: /\A\s*https?:\/\//, message: "must be a valid URL (must start with http:// or https://)", allow_blank: true }

  def can_be_edited_by?(user)
    user.admin? || user == self.board.user
  end
end
