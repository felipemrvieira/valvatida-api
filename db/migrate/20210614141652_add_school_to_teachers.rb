class AddSchoolToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_reference :teachers, :school, foreign_key: true
  end
end
