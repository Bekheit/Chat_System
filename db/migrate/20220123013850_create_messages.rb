class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :content
      t.integer :chat_id
      t.integer :number

      t.timestamps
    end
  end
end
