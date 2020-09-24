class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :description
      t.integer :point
      t.integer :parent_id
      t.integer :child_id
      t.date :request_date
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
end
