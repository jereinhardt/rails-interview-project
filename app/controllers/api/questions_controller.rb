module API
  class QuestionsController < APIController
    def index
      @questions = Question.visible

      respond_to do |format|
        format.json { render json: @questions }
      end
    end
  end
end