# frozen_string_literal: true

# == Schema Information
#
# Table name: visits
#
#  id           :bigint           not null, primary key
#  latitude     :decimal(, )
#  longitude    :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  short_url_id :bigint
#
# Indexes
#
#  index_visits_on_short_url_id  (short_url_id)
#
FactoryBot.define do
  factory :visit do
    latitude { '9.99' }
    longitude { '9.99' }
  end
end
