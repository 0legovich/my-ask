class HashtagQuestion < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :question

  validates :hashtag, :question, presence: true
end
