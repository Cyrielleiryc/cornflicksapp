class AddShareablecodeToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :shareablecode, :string
  end
end
