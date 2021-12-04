class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :followed_id, foreign_key: { to_table: 'users' }, null: false, index: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
