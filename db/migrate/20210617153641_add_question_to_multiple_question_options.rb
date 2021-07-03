class AddQuestionToMultipleQuestionOptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :multiple_question_options, :question, foreign_key: true
  end
end
