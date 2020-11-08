class Quiz < ApplicationRecord
  belongs_to :user

  has_many :questions, inverse_of: :quiz
  has_many :answers, through: :questions

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
  validates :questions, presence: { message: 'must have at least one question' }

end
