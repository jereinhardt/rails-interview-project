class APIController < ApplicationController
  before_action :authenticate_request
  before_action :track_request

  def current_tenant
    @current_tenant ||= Tenant.find_by(api_key: params[:api_key])
  end

  def render_json(data:, status: :ok)
    render json: { data: data, errors: [] }, status: status
  end

  def render_error(message:, status:)
    render json: { data: {}, errors: [message] }, status: status
  end

  private

  def authenticate_request
    unless current_tenant.present?
      render_error(message: "Unauthorized", status: :unauthorized)
    end
  end

  def track_request
    APIRequestTracking.new(tenant: current_tenant, request: request).perform
  end
end
