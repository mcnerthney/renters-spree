class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :email

      t.timestamps
    end
  end
end
