class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.string :name
      t.string :login_id
      t.string :password_digest
      t.binary :icon
      t.integer :parent_id

      t.timestamps
    end
  end
end
