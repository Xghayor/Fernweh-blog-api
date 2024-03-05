class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :image
      t.integer :posts_counter
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
