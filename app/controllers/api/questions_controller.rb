module API
  class QuestionsController < APIController
    def index
      status = questions.none? ? :no_content : :ok

      respond_to do |format|
        format.json { render_json(data: serialized_questions, status: status) }
      end
    end

    private

    def questions
      @questions ||= Question.
        visible.
        includes(:asker, answers: :answerer).
        ransack(params[:q]).
        result
    end

    def serialized_questions
      ActiveModelSerializers::SerializableResource.new(
        questions,
        include: "answers.answerer"
      )
    end
  end
end