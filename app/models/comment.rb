class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :text, presence: true
  validates :user, presence: true
  validates :post, presence: true

  after_create :update_comments_counter
  after_destroy :update_comments_counter

  private

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
