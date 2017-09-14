class Hashtag < ActiveRecord::Base

  validates :text, precence: true
end
