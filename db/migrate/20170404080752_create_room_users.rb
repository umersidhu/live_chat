# frozen_string_literal: true
class CreateRoomUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :room_users, id: false do |t|
      t.column :id,                 :primary_key, unsigned: true
      t.integer :user_id,                         unsigned: true
      t.integer :room_id,                         unsigned: true
      t.integer :last_read_message_id
      t.integer :unread_message_count,            default: 0

      t.timestamps
    end

    add_index :room_users, :user_id
    add_index :room_users, :room_id
    add_index :room_users, [:user_id, :room_id], unique: true
  end
end
