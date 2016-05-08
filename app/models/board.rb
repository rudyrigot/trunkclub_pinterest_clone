class Board < ActiveRecord::Base
  belongs_to :user
  has_many :pins, -> { order(:created_at) }, dependent: :destroy

  validates :title, :user_id, presence: true

  def title_with_user
    "\"#{title}\" by #{user.full_name}"
  end

  def can_be_edited_by?(user)
    user.admin? || user == self.user
  end
end
