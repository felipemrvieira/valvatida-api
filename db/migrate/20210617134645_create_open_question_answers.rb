class CreateOpenQuestionAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :open_question_answers do |t|
      t.string :answer
      t.references :question, foreign_key: true
      t.timestamps
    end
  end
end
