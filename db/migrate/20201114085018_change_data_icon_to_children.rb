class ChangeDataIconToChildren < ActiveRecord::Migration[5.2]
  def change
    change_column :children, :icon, :string
  end
end
