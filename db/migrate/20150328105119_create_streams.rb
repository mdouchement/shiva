class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :path
      t.integer :size
      t.string :content_type
      t.integer :duration
      t.string :hexdigest

      t.belongs_to :track

      t.timestamps null: false
    end
  end
end
