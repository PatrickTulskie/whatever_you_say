class UpdateProfiles < ActiveRecord::Migration
  def self.up
    rename_column "profiles", "language", "language_id"

  end

  def self.down
    rename_column "profiles", "language_id", "language"

  end
end
