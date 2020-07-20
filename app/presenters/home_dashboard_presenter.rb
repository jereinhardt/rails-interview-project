class HomeDashboardPresenter

  def users_count
    @users_count ||= User.all.count
  end

  def questions_count
    @questions_count ||= Question.all.count
  end

  def answers_count
    @answers_count ||= Answer.all.count
  end

  def api_requests_count
    @api_requests_count ||= APIRequest.all.count
  end

end