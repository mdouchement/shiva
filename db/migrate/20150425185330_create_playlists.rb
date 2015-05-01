class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name, null: false
      t.string :token, null: false

      t.timestamps null: false
    end

    add_index :playlists, :name, unique: true

    create_table :tracks_playlists, id: false do |t|
      t.belongs_to :playlist, index: true
      t.belongs_to :track, index: true
    end

    create_table :playlists_tracks, id: false do |t|
      t.belongs_to :playlist, index: true
      t.belongs_to :track, index: true
    end
  end
end
