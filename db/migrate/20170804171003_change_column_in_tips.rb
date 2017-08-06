class ChangeColumnInTips < ActiveRecord::Migration[5.0]
  def change
    rename_column :tips, :email, :description
    change_column :tips, :description, :text
  end
end
