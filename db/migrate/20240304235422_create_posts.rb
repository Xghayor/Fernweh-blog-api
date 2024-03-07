class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :image
      t.integer :comments_counter, default: 0
      t.integer :likes_counter, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
