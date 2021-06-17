class RenameTypeQuestionToKind < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :type, :kind

  end
end
