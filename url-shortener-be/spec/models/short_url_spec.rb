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
require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
