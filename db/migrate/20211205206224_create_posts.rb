class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false, index: true
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    
    add_column :posts, :ahoy_visit_id, :bigint
    add_index :posts, :ahoy_visit_id
  end
end
