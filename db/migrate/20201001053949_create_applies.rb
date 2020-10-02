class CreateApplies < ActiveRecord::Migration[5.2]
  def change
    create_table :applies do |t|
      t.integer :request_id
      t.string :comment
      t.date :completion_date
      t.boolean :close, null: false, default: false

      t.timestamps
    end
  end
end
