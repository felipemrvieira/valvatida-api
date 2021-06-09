class RemoveSubdomainFromSchools < ActiveRecord::Migration[5.2]
  def change
    remove_column :schools, :subdomain

  end
end
