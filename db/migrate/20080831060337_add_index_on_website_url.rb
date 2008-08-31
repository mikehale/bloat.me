class AddIndexOnWebsiteUrl < ActiveRecord::Migration
  def self.up
    add_index(:links, :website_url)
  end

  def self.down
    remove_index(:links, :website_url)
  end
end
