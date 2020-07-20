class QuestionSerializer < ActiveModel::Serializer

  attributes :id, :title

  belongs_to :asker, serializer: UserSerializer

  has_many :answers

end