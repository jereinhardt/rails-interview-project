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
      { data: {}, errors: ["Unauthorized"] }.to_json
    )
    assert_response :unauthorized
  end

  test "should return public questions as serialized json" do
    questions = questions(:two, :one)
    tenant = tenants(:one)
    serialized_questions = ActiveModelSerializers::SerializableResource.new(
      questions,
      include: "answers.answerer"
    )

    get :index, api_key: tenant.api_key, format: :json

    assert_equal @response.body, json_success_response(serialized_questions)
  end

  test "should log the request on the tenant" do
    tenant = tenants(:one)

    assert_difference -> { tenant.api_requests.count } do
      get :index, api_key: tenant.api_key, format: :json
    end
  end

  test "should return results that match a search when provided" do
    tenant = tenants(:one)
    title = "Question 1"
    questions = Question.where(title: title)
    serialized_questions = ActiveModelSerializers::SerializableResource.new(
      questions,
      include: "answers.answerer"
    )

    get :index,
      api_key: tenant.api_key,
      format: :json,
      q: { title_matches: title }

    assert_equal @response.body, json_success_response(serialized_questions)
  end

  test "should return the proper result when no search results are found" do
    tenant = tenants(:one)

    get :index,
      api_key: tenant.api_key,
      format: :json,
      q: { title_matches: "No questions should match this title" }

    assert_response :no_content
    assert_equal @response.body, { data: [], errors: [] }.to_json
  end

  private

  def json_success_response(data)
    { data: data, errors: [] }.to_json
  end
end
