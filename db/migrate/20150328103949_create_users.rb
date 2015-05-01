class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, default: ''
      t.string :avatar, null: true

      t.timestamps null: false
    end

    add_index :users, :username, unique: true
  end
end
