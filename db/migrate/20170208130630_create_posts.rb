class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :content
      t.integer :comment_count

      t.timestamps
    end
  end
end
