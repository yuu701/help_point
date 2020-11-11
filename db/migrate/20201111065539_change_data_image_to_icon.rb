class ChangeDataImageToIcon < ActiveRecord::Migration[5.2]
  def change
    change_column :icons, :image, :string
  end
end
