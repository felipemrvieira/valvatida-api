class CreateAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts do |t|
      t.references :question, foreign_key: true
      t.references :student, foreign_key: true
      t.boolean :hit

      t.timestamps
    end
  end
end
