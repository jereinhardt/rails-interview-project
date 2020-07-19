require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test ".visible" do
    private_question = questions(:private)
    public_questions = questions(:one, :two)
    results = Question.visible

    assert_not results.include?(private_question)
    public_questions.each do |question|
      assert results.include?(question)
    end
  end
end
