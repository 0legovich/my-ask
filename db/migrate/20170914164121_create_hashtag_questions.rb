class CreateHashtagQuestions < ActiveRecord::Migration
  def change
    create_table :hashtag_questions do |t|
      t.references :hashtag
      t.references :question

      t.timestamps null: false
    end
  end
end
