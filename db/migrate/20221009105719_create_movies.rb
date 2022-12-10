class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.integer :genre_id, null:false
      t.integer :tmdb_id, null:false
      t.string :title, null:false
      t.text :synopsis, null:false
      t.string :directer, null:false
      t.string :screen_writer, null:false
      t.string :perfomer, null:false
      
      t.timestamps
    end
  end
end
