class AddTypeToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :type, :integer, default: 0

  end
end
