# frozen_string_literal: true
class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.text    :title

      t.timestamps
    end

    add_index :rooms, :owner_id
    add_index :rooms, :room_icon_id
  end
end
