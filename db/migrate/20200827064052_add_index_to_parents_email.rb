class AddIndexToParentsEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :parents, :email, unique: true
  end
end
