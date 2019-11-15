class AddSpecialFieldToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :special_field, :string
  end
end
