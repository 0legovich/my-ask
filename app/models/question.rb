class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: 'User'
  has_many :hashtags

  accepts_nested_attributes_for :hashtags, :allow_destroy => true

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }
end
