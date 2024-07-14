# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShortUrls', type: :request do
  describe 'POST /' do
    subject(:request) { post '/short_urls', params: }

    let(:params) { {} }

    context 'when given valid URL' do
      let(:params) { { original_url: 'https://www.coingecko.com' } }

      it 'returns 201 CREATED' do
        request

        expect(response).to have_http_status(:created)
      end

      it { expect { request }.to(change { ShortUrl.count(1) }) }
    end

    context 'when given an invalid URL' do
      let(:params) { nil }

      it 'returns 400 CREATED' do
        request

        expect(response).to have_http_status(:bad_request)
      end

      it { expect { request }.not_to(change { ShortUrl.count(1) }) }
    end
  end
end
