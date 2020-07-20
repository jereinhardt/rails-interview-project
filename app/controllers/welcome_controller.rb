class WelcomeController < ApplicationController
  def index
    @dashboard = HomeDashboardPresenter.new
  end
end
