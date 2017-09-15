class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find(params[:id])

    @questions = Question.joins(:hashtags).where(hashtags: {text: @hashtag.text})
  end

end
