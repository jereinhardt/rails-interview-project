require 'test_helper'

class HomeDashboardPresenterTest < ActiveSupport::TestCase
  test "#users_count" do
    total_users = User.all.count
    presenter = HomeDashboardPresenter.new

    assert_equal presenter.users_count, total_users
  end

  test "#questions_count" do
    total_questions = Question.all.count
    presenter = HomeDashboardPresenter.new

    assert_equal presenter.questions_count, total_questions
  end

  test "#answers_count" do
    total_answers = Answer.all.count
    presenter = HomeDashboardPresenter.new

    assert_equal presenter.answers_count, total_answers
  end

  test "#api_requests_count" do
    total_api_requests = APIRequest.all.count
    presenter = HomeDashboardPresenter.new

    assert_equal presenter.api_requests_count, total_api_requests
  end
end
