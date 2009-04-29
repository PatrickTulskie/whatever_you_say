class AddClosedColumnsToChats < ActiveRecord::Migration
  def self.up
    add_column :chats, :user_closed, :boolean
    add_column :chats, :receiver_closed, :boolean
  end

  def self.down
    remove_column :chats, :user_closed
    remove_column :chats, :receiver_closed
  end
end
