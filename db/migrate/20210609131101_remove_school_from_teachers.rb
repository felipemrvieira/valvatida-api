class RemoveSchoolFromTeachers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :teachers, :school, foreign_key: true
  end
end
