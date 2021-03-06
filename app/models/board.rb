class Board < ActiveRecord::Base
  belongs_to :user
  has_many :pins, -> { order(:created_at) }, dependent: :destroy
  has_and_belongs_to_many :subscribers, class_name: "User", join_table: "subscriptions"

  validates :title, :user_id, presence: true

  scope :random, -> { includes(:user).order("RANDOM()").limit(10) }

  def title_with_user
    "\"#{title}\" by #{user.full_name}"
  end

  def can_be_edited_by?(user)
    user.admin? || user == self.user
  end
end
