class ChangePublicPlaceToStreet < ActiveRecord::Migration[5.2]
  def change
    rename_column :addresses, :public_place, :street
  end
end
