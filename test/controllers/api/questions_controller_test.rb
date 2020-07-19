require 'test_helper'

class API::QuestionsControllerTest < ActionController::TestCase
  test "should allow requests with a valid api token" do
    tenant = tenants(:one)

    get :index, api_key: tenant.api_key, format: :json

    assert_response :success
  end

  test "should reject requests with an invalid api token" do
    get :index, api_key: "NOTAKEY"

    assert_equal(
      @response.body,
      { data: {}, errors: ["Unauthorized"], meta: {} }.to_json
    )
    assert_response :unauthorized
  end

  test "should return public questions as json" do
    questions = questions(:two, :one)
    tenant = tenants(:one)

    get :index, api_key: tenant.api_key, format: :json

    assert_equal(
      @response.body,
      questions.to_json
    )
  end

  test "should log the request on the tenant" do
    tenant = tenants(:one)

    assert_difference -> { tenant.api_requests.count } do
      get :index, api_key: tenant.api_key, format: :json
    end
  end
end
