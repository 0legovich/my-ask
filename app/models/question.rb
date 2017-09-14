class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: 'User'
  has_many :hashtag_questions
  has_many :hashtags, through: :hashtag_questions

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}

  before_create :create_hashtag

  def create_hashtag
    #eсли хештеги присутстуют в вопросе то мы их создаем или если они уже созданы
    #то присваиваем этому вопросу id хештега (mamy-to-many)
    unless self.contained_hashtags.empty?
      unless Hashtag.where(text: contained_hashtags).empty?
        #присваиваем этому вопросу хештеги contained_hashtag
      else
        #создаем хештеги contained_hashtags
        contained_hashtags.each { |hashtag| Hashtag.create!(text: hashtag) }
        #присваиваем этому вопросу хештеги contained_hashtags
      end
    end
  end

  def contained_hashtags
    text.split.select {|elem| elem.include?('#')}
  end
end
