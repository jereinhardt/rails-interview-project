module API
  class QuestionsController < APIController
    def index
      questions = Question.visible
      serialized_questions = ActiveModelSerializers::SerializableResource.new(
        questions,
        include: "answers.answerer"
      )

      respond_to do |format|
        format.json { render_json(serialized_questions) }
      end
    end
  end
end