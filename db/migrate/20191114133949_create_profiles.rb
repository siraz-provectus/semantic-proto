class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :city

      t.timestamps
    end
  end
end
