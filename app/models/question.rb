class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: 'User'
  has_many :hashtag_questions
  has_many :hashtags, through: :hashtag_questions

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}

  after_commit :update_question_hashtags

  def update_question_hashtags
    question_hashtags = find_hashtags(text) + find_hashtags(answer)

    question_hashtags.each do |hsh|
      new_nashtag = Hashtag.find_or_create_by(text: hsh)
      HashtagQuestion.find_or_create_by(question: self, hashtag: new_nashtag)
    end
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
