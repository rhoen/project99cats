class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false
      t.string :device
      t.string :ip

      t.timestamps
    end
    add_index :sessions, :user_id
  end
end
