# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /:short_url', type: :request do
  subject(:request) { get "/#{short_url}" }

  let!(:existing) { create(:short_url) }
  let(:short_url) { nil }

  context 'when given existing short_url' do
    let(:short_url) { existing.id }

    it 'returns 302 FOUND' do
      request

      expect(response).to have_http_status(:found)
    end

    it 'returns location header' do
      request

      expect(response.headers['Location']).to eq(existing.target_url)
    end

    it 'tracks visits' do
      expect { request }.to(change { Visit.count(1) })
    end
  end

  context 'when given non-existent short_url' do
    it 'returns 404 NOT FOUND' do
      request

      expect(response).to have_http_status(:not_found)
    end
  end
end
