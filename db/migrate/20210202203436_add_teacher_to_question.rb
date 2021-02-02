class AddTeacherToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :teacher, foreign_key: true
  end
end
