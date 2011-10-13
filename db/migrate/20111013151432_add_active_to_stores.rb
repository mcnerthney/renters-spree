class AddActiveToStores < ActiveRecord::Migration
  def change
    add_column :stores, :active, :boolean
  end
end
