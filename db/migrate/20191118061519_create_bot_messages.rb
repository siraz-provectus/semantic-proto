class CreateBotMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :bot_messages do |t|
      t.integer :profile_id
      t.integer :message_id
      t.integer :question_id

      t.timestamps
    end
  end
end
