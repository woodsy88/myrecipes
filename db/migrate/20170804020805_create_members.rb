class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :membername
      t.string :email
      t.timestamps
    end
  end
end
