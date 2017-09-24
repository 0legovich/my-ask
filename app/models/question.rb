class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: 'User'
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}

  after_commit :update_question_hashtags, on: [:update, :create]

  def update_question_hashtags
    scanned_hashtags.each do |hsh|
      new_nashtag = Hashtag.find_or_create_by(text: hsh)
      HashtagQuestion.find_or_create_by(question: self, hashtag: new_nashtag)
    end

    self.hashtag_questions.each do |hsh|
      hsh.destroy! unless scanned_hashtags.include?(hsh.hashtag.text)
    end
  end

  def scanned_hashtags
    "#{text} #{answer}".scan(/\#[а-яА-Яa-zA-z\d-]+/).map(&:downcase).uniq
  end
end
