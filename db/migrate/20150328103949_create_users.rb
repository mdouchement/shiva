class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false, default: ''
      t.string :avatar, null: false, default: 'http://www.lasanacronistas.net/wp-content/uploads/2011/05/random-icon.png'

      t.timestamps null: false
    end
  end
end
