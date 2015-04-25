class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :tracks_playlists, id: false do |t|
      t.belongs_to :playlist, index: true
      t.belongs_to :track, index: true
    end
  end
end
