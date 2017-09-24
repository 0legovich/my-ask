class Hashtag < ActiveRecord::Base
  belongs_to :question
  has_many :hashtag_question

  validates :text, presence: true

  scope :used_now, -> {joins(
    'LEFT JOIN hashtag_questions ON hashtag_questions.hashtag_id = hashtags.id'
  ).where.not(hashtag_questions: {id: nil}).uniq}
end
