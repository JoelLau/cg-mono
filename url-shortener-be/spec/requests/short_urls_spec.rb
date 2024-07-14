# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShortUrls', type: :request do
  describe 'POST /' do
    subject(:request) { post '/short_urls', params: {} }

    before { request }

    it { expect(response).to have_http_status(:created) }
    it { expect { request }.to(change { ShortUrl.count(1) }) }
  end
end
