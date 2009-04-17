class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :force => true do |t|
      t.integer :sender_id
      t.integer :chat_id
      t.integer :source_language_id
      t.string :body

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
