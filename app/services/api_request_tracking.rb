class APIRequestTracking
  def initialize(tenant:, request:)
    @tenant = tenant
    @request = request
  end

  def perform
    tracking_attributes = {
      endpoint: request.path,
      method: request.request_method,
      params: request.params.except("api_key")
    }
    tenant.api_requests.create(tracking_attributes)
  end

  private

  attr_reader :tenant, :request
end