class CreateHashtagQuestions < ActiveRecord::Migration
  def change
    create_table :hashtag_questions do |t|
      t.references :hashtag, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
