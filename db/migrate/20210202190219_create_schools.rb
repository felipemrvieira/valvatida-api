class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
