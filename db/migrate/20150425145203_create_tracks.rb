class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.belongs_to :user
      t.string :album
      t.string :artist
      t.string :title
      t.string :track_number
      t.string :hexdigest

      t.timestamps null: false
    end

    add_index :tracks, :album
    add_index :tracks, :artist
    add_index :tracks, :title
    add_index :tracks, :hexdigest
  end
end
