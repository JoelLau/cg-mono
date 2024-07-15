# frozen_string_literal: true

# == Schema Information
#
# Table name: short_urls
#
#  id         :bigint           not null, primary key
#  target_url :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortUrl < ApplicationRecord
end
