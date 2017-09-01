class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.integer :member_id
      t.integer :tip_id
      t.timestamps
    end
  end
end
