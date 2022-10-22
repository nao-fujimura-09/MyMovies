class CreateWatchLists < ActiveRecord::Migration[6.1]
  def change
    create_table :watch_lists do |t|
      t.integer :user_id, null: false
      t.integer :movie_id, null: false
      t.timestamps
    end
  end
end
