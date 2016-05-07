class Pin < ActiveRecord::Base
  belongs_to :board

  validates :title, :link, :board_id, presence: true
end
