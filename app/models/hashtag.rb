class Hashtag < ActiveRecord::Base
  belongs_to :question
  has_many :hashtag_questions

  validates :text, presence: true

  scope :used_now, -> {joins(:hashtag_questions).distinct("hashtag.id")}
end
