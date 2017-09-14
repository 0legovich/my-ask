class CreateHashtagQuestions < ActiveRecord::Migration
  def change
    create_table :hashtag_questions do |t|
      t.reference :hashtag
      t.reference :question

      t.timestamps null: false
    end
  end
end
