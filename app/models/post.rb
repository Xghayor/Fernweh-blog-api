class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }
  validates :content, presence: true
  validates :image, presence: true
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user, presence: true

  after_create :update_counters
  after_destroy :update_counters

  private

  def update_counters
    user.update(posts_counter: user.posts.count)
  end
end
