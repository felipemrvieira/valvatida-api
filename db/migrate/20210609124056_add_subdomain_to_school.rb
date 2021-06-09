class AddSubdomainToSchool < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :subdomain, :string
  end
end
