  class AddMemberIdToTips < ActiveRecord::Migration[5.0]
    def change
       add_column :tips, :member_id, :integer   
    end
  end
