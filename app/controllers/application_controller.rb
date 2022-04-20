class ApplicationController < ActionController::API
  include Authorization

  private

  def render_error(message, status = :bad_request)
    Rails.logger.warn { message }
    render json: { errors: [{ detail: message }] }, status: status
  end
end
