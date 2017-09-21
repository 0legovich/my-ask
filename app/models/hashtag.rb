class Hashtag < ActiveRecord::Base
  belongs_to :question
  has_many :hashtag_question

  validates :text, presence: true
end
