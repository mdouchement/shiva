class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :album
      t.string :artist
      t.string :title
      t.string :track_number
      t.string :hexdigest

      t.timestamps null: false
    end
  end
end
