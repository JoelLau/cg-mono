# frozen_string_literal: true

# :nodoc:
class ShortUrlsController < ApplicationController
  def create
    record = ShortUrls.new(original_url_param)
    render json: { data: record }, status: :created
  end

  private

  def original_url_param
    params[:original_url]
  end
end
