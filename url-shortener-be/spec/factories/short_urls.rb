# frozen_string_literal: true

FactoryBot.define do
  factory :short_url do
    target_url { 'https://www.example.com' }
  end
end
