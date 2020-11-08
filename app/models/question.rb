class Question < ApplicationRecord
  belongs_to :quiz

  has_many :answers, inverse_of: :question
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  validates :answers, presence: { message: 'must have at least one answers' }

  enum types: {
    free_response: "Free Response",
    multiple_responses: "Multiple Responses"
  }



end
