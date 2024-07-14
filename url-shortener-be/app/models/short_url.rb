# frozen_string_literal: true

# == Schema Information
#
# Table name: short_urls
#
#  id           :bigint           not null, primary key
#  original_url :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_short_urls_on_original_url  (original_url) UNIQUE
#
class ShortUrl < ApplicationRecord
end
