class CreateCourseGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :course_groups do |t|
      t.string :title

      t.timestamps
    end
  end
end
