class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: 'User'
  has_many :hashtag_questions
  has_many :hashtags, through: :hashtag_questions

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}

  after_commit :create_hashtag

  def create_hashtag
    #eсли хештеги присутстуют в вопросе то мы их создаем или если они уже созданы
    #то присваиваем этому вопросу id хештега (mamy-to-many)
    question_hashtags = self.contained_hashtags
    exist_hashtags = Hashtag.where(text: question_hashtags).to_a
    unless question_hashtags.empty?
      unless exist_hashtags.empty?
        #присваиваем этому вопросу хештеги contained_hashtag
        add_hashtags_to_question(exist_hashtags)
      else
        #создаем хештеги contained_hashtags
        new_hashtags = []
        question_hashtags.each { |hashtag| new_hashtags << Hashtag.create!(text: hashtag) }

        #присваиваем этому вопросу хештеги contained_hashtags
        add_hashtags_to_question(new_hashtags)
      end
    end
  end

  def contained_hashtags
    text.split.select {|elem| elem.include?('#')}
  end

  def add_hashtags_to_question(exist_hashtags)
    exist_hashtags.each do |hashtag|
      HashtagQuestion.create!(hashtag: hashtag, question: self)
    end
  end
end
