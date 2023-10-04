class RemoveCategoryFromImages < ActiveRecord::Migration[7.0]
  def change
    remove_column :images, :category, :string
  end
end
