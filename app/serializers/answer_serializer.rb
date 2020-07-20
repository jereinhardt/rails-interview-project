class AnswerSerializer < ActiveModel::Serializer

  attributes :id, :body

  belongs_to :question
  belongs_to :answerer, serializer: UserSerializer

end
