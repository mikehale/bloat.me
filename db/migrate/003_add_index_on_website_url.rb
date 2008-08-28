class AddIndexOnWebsiteUrl < ActiveRecord::Migration
  def self.up
    execute "CREATE INDEX website_url_index ON links (website_url(200));"
  end

  def self.down
    execute "DROP INDEX website_url_index on links;"
  end
end
