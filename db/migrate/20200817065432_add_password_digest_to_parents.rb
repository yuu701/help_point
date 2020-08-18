class AddPasswordDigestToParents < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :password_digest, :string
  end
end
