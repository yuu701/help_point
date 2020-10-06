class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.date :completion_date
      t.string :name
      t.string :description
      t.integer :point
      t.integer :bonus
      t.string :appeal_comment
      t.string :parents_comment
      t.integer :child_id

      t.timestamps
    end
  end
end
