# frozen_string_literal: true

# :nodoc:
class ShortUrlsController < ApplicationController
  def create
    return render_errors(['request body must contain field: target_url'], :bad_request) unless target_url_param

    short_url = ShortUrl.new({ target_url: target_url_param })
    return render_errors(short_url.errors.full_messages, :unprocessable_entity) unless short_url.save

    render json: {
      data: {
        target_url: short_url.target_url,
        short_url: short_url.id
      }
    }, status: :created
  end

  def redirect
    @short_url = ShortUrl.find(params[:short_url])

    return render json: { error: 'Short URL not found' }, status: :not_found unless @short_url

    # TODO: move creation somewhere more appropriate
    # TODO: add geolocation info
    visit = Visit.new({ short_url_id: @short_url.id })
    visit.save

    redirect_to @short_url.target_url, allow_other_host: true
  end

  private

  def target_url_param
    params.require(:target_url)
  end

  def render_errors(errors, status)
    render json: { errors: }, status:
  end
end
