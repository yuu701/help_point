class CreateHelps < ActiveRecord::Migration[5.2]
  def change
    create_table :helps do |t|
      t.string :name
      t.string :description
      t.integer :point
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
  end
end
