class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, default: ''
      t.string :avatar, null: true
      t.string :streaming_behavior, default: 'send_file'
      t.string :reindexing_path, default: ''

      t.timestamps null: false
    end

    add_index :users, :username, unique: true
  end
end
