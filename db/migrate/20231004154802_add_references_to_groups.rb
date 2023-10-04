class AddReferencesToGroups < ActiveRecord::Migration[7.0]
  def change
    add_reference :groups, :image, foreign_key: true
  end
end
