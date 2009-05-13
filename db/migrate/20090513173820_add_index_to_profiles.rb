class AddIndexToProfiles < ActiveRecord::Migration
  def self.up
    add_index :profiles, :language_id
  end

  def self.down
    remove_index :profiles, :language_id
  end
end
