class AddUserColumnToCats < ActiveRecord::Migration
  def change
    add_column :cats, :owner_id, :integer
    change_column :cats, :owner_id, :integer, null: false
    add_index :cats, :owner_id
  end

end
