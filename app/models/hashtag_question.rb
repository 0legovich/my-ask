class HashtagQuestion < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :question

  validates :hashtag, :question, presence: true
  validates :hashtag, uniqueness: {scope: :question_id}
end
