class CreateMultipleQuestionOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :multiple_question_options do |t|
      t.string :label
      t.boolean :correct

      t.timestamps
    end
  end
end
