# frozen_string_literal: true

# :nodoc:
class CreateShortUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :short_urls do |t|
      t.string :short_url, null: true, index: { unique: true }

      t.timestamps
    end
  end
end
