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
require 'rails_helper'

RSpec.describe Visit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
