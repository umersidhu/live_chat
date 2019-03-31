# frozen_string_literal: true
class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :room_id,                unsigned: true
      t.integer :user_id,                unsigned: true
      t.text    :content

      t.timestamps
    end

    add_index :messages, :room_id
    add_index :messages, :user_id
  end
end
