class APIController < ApplicationController
  before_action :authenticate_request
  before_action :track_request

  def current_tenant
    @current_tenant ||= Tenant.find_by(api_key: params[:api_key])
  end

  private

  def authenticate_request
    unless current_tenant.present?
      render json: { data: {}, errors: ["Unauthorized"], meta: {} }, status: :unauthorized
    end
  end

  def track_request
    APIRequestTracking.new(tenant: current_tenant, request: request).perform
  end
end