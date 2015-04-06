class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :path
      t.integer :size
      t.string :content_type
      t.float :x_content_duration

      t.timestamps null: false
    end
  end
end
