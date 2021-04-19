class CreateSchoolAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :school_admins do |t|
      t.references :school, foreign_key: true
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
