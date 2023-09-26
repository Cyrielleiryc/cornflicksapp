class AddReferenceToGroups < ActiveRecord::Migration[7.0]
  def change
    add_reference :groups, :creator, foreign_key: { to_table: :users }
  end
end
