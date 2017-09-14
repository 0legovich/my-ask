class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :text
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
