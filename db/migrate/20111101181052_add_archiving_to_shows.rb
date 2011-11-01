class AddArchivingToShows < ActiveRecord::Migration
  def change
    add_column :shows, :archiveId, :string
    add_column :shows, :archiveShow, :boolean, { :default => false }
  end
end
