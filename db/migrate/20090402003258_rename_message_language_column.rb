class RenameMessageLanguageColumn < ActiveRecord::Migration
  def self.up
    rename_column :messages, :source_language_id, :language_id
  end

  def self.down
    rename_column :messages, :language_id, :source_language_id
  end
end
