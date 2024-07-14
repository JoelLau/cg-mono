# frozen_string_literal: true

# == Schema Information
#
# Table name: short_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_short_urls_on_short_url  (short_url) UNIQUE
#
class ShortUrl < ApplicationRecord
end
