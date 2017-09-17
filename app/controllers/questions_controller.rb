class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  before_action :autorize_user, except: [:create]

  def edit
  end

  def create
    @question = Question.new(question_params)

    set_questions_hashtags
    create_hashtags(@questions_hashtags)

    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос задан.'
    else
      render :edit
    end
  end

  def update
    if @question.update(question_params)
      set_questions_hashtags

      new_hashtags = @questions_hashtags - @question.hashtags.map(&:text)
      inactive_hashtags = @question.hashtags.where.not(text: @questions_hashtags)

      create_hashtags(new_hashtags)
      destroy_hashtags(inactive_hashtags)

      redirect_to user_path(@question.user), notice: 'Вопрос сохранен.'
    else
      render :edit
    end
  end

  def destroy
    user = @question.user
    destroy_hashtags(@question.hashtags)

    @question.destroy
    redirect_to user_path(user), notice: 'Вопрос удален.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def load_question
    @question = Question.find(params[:id])
  end

  def autorize_user
    reject_user unless @question.user == current_user
  end

  def question_params
    if current_user.present? && params[:question][:user_id].to_i == current_user.id
      params.require(:question).permit(:user_id, :text, :answer)
    else
      params.require(:question).permit(:user_id, :text)
    end
  end

  def set_questions_hashtags
    @questions_hashtags = @question.text.scan(/\#[а-яА-Яa-zA-z\d-]+/).map(&:downcase)

    unless @question.answer.blank?
      @questions_hashtags += @question.answer.scan(/\#[а-яА-Яa-zA-z\d-]+/).map(&:downcase)
    end
  end

  def create_hashtags(hashtags)
    return unless hashtags
    @question.hashtags_attributes = hashtags.map {|hashtag| {text: hashtag, question: @question}}
    @question.save
  end

  def destroy_hashtags(hashtags)
    hashtags.each do |hashtag|
      @question.hashtags_attributes = {:id => hashtag.id.to_s, '_destroy' => '1'}
    end
    @question.save
  end
end
