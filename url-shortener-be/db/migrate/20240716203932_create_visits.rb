# frozen_string_literal: true

# :nodoc:
class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end

    add_reference :visits, :short_url
  end
end
