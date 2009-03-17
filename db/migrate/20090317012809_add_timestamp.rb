class AddTimestamp < ActiveRecord::Migration
  def self.up
    add_column "profiles", "timestamp", :boolean
  end

  def self.down
    remove_column "profiles", "timestamp"
  end
end
