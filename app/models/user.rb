class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
    has_many :posts
    has_many :comments
    has_many :likes
    has_one_attached :image

    validates :name, presence: true, length: { minimum: 2, maximum: 50 }
    validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validate :image_size

  private

  def image_size
    if image.attached? && image.byte_size > 1.megabyte
      errors.add(:image, "should be less than 1MB")
    end
  end
end
