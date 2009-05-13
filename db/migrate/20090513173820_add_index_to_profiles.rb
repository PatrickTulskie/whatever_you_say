class AddIndexToProfiles < ActiveRecord::Migration
  def self.up
    add_index :profiles, [:language_id, :user_id]
    add_index :profiles, :user_id
  end

  def self.down
    remove_index :profiles, [:language_id, :user_id]
    remove_index :profiles, :user_id
  end
end
