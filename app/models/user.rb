class User < ActiveRecord::Base
  has_many :boards, -> { order(:title) }, dependent: :destroy

  has_and_belongs_to_many :subscriptions, class_name: "Board", join_table: "subscriptions"

  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :first_name, :last_name, presence: true


  # @return [Boolean] true if user is admin or rudy.rigot@gmail.com
  def admin?
    admin || email == 'rudy.rigot@gmail.com'
  end

  def full_name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    else
      email
    end
  end

  # @return [String] a random password of size 10
	def self.random_password
		Array.new(10).map { (65 + rand(58)).chr }.join
	end
end
