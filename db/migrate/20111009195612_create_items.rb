class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.string :location
      t.integer :owner_id

      t.timestamps
    end
  end
end
