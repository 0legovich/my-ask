class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: 'User'
  has_many :hashtags

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}

  after_commit :update_question_hashtags

  def update_question_hashtags
    question_hashtags = find_hashtags(text) + find_hashtags(answer)

    question_hashtags.each {|hsh| Hashtag.find_or_create_by(question: self, text: hsh)}
    self.hashtags.each {|hsh| hsh.destroy! unless question_hashtags.include?(hsh.text)}
  end

  def find_hashtags(sentence)
    unless sentence.blank?
      sentence.scan(/\#[а-яА-Яa-zA-z\d-]+/).map(&:downcase)
    else
      []
    end
  end
end
