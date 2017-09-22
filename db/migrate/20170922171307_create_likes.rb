class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.boolean :like
      t.integer :member_id
      t.integer :tip_id
      t.timestamps
    end
  end
end
