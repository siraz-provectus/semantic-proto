class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :quiz_id
      t.string :description
      t.integer :priority

      t.timestamps
    end
  end
end
