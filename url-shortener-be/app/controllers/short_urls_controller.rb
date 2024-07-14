# frozen_string_literal: true

# :nodoc:
class ShortUrlsController < ApplicationController
  def create
    original_url_param = params[:original_url]

    unless original_url_param
      render json: { errors: ['request body must contain field: original_url'] },
             status: :bad_request
      return
    end

    @short_url = ShortUrl.new({ original_url: original_url_param })
    render json: { errors: @short_url.errors.full_messages }, status: :unprocessable_entity unless @short_url.save

    render json: { data: @short_url }, status: :created
  end
end
