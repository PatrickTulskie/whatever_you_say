class CreateChats < ActiveRecord::Migration
  def self.up
    create_table :chats do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.integer :user_read_count
      t.integer :receiver_read_count

      t.timestamps
    end
  end

  def self.down
    drop_table :chats
  end
end
