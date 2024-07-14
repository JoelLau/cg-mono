class CreateShortUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :short_urls do |t|
      t.string :short_url

      t.timestamps
    end
  end
end
