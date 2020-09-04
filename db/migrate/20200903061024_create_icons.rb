class CreateIcons < ActiveRecord::Migration[5.2]
  def change
    create_table :icons do |t|
      t.binary :image, limit: 1.megabyte

      t.timestamps
    end
  end
end
