class AddImageToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :tips, :image, :string
  end
end
