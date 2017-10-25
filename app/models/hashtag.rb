class Hashtag < ActiveRecord::Base
  has_many :hashtag_questions
  has_many :questions, through: :hashtag_questions

  validates :text, presence: true

  scope :used_now, -> { joins(:hashtag_questions).distinct("hashtag.id") }
end
