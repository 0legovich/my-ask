class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: 'User'
  has_many :hashtag_questions
  has_many :hashtags, through: :hashtag_questions

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }
end
