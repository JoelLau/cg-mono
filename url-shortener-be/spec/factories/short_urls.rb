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
FactoryBot.define do
  factory :short_url do
    target_url { 'https://www.example.com' }
  end
end
