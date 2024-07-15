# frozen_string_literal: true

# :nodoc:
class ShortUrlsController < ApplicationController
  def create
    if original_url_param.nil? || original_url_param.blank?
      return render_errors(['request body must contain field: original_url'],
                           :bad_request)
    end

    short_url = ShortUrl.new({ original_url: original_url_param })
    return render_errors(short_url.errors.full_messages, :unprocessable_entity) unless short_url.save

    render json: { data: short_url }, status: :created
    # rescue NotNullValidation
    #   render json: { errors: ['original_url cannot be null'] }, status: :bad_request
  end

  private

  def original_url_param
    return nil if params.nil? || params.blank?

    params[:original_url]
  end

  def render_errors(errors, status)
    render json: { errors: }, status:
  end
end
