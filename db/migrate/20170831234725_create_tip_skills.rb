class CreateTipSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :tip_skills do |t|
      t.integer :tip_id
      t.integer :skill_id
    end
  end
end
