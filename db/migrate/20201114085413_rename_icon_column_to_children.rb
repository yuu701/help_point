class RenameIconColumnToChildren < ActiveRecord::Migration[5.2]
  def change
    rename_column :children, :icon, :icon_id
  end
end
