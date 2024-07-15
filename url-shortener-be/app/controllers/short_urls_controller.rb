# frozen_string_literal: true

# :nodoc:
class ShortUrlsController < ApplicationController
  def create
    if target_url_param.nil? || target_url_param.blank?
      return render_errors(['request body must contain field: target_url'],
                           :bad_request)
    end

    short_url = ShortUrl.new({ target_url: target_url_param })
    return render_errors(short_url.errors.full_messages, :unprocessable_entity) unless short_url.save

    render json: { data: short_url }, status: :created
    # rescue NotNullValidation
    #   render json: { errors: ['target_url cannot be null'] }, status: :bad_request
  end

  private

  def target_url_param
    return nil if params.nil? || params.blank?

    params[:target_url]
  end

  def render_errors(errors, status)
    render json: { errors: }, status:
  end
end
