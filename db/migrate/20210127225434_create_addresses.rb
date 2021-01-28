class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :public_place
      t.string :number
      t.string :ref
      t.string :lat
      t.string :long
      t.references :neighborhood, foreign_key: true

      t.timestamps
    end
  end
end
