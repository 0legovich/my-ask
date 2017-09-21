class RemoveQuestionFromHashtag < ActiveRecord::Migration
  def change
    remove_reference :hashtags, :question, index: true
  end
end
