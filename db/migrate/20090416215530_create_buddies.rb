class CreateBuddies < ActiveRecord::Migration
  def self.up
    create_table :buddies do |t|
      t.integer :buddy_group_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :buddies
  end
end
