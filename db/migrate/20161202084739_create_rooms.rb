# frozen_string_literal: true
class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.text    :title

      t.timestamps
    end

  end
end
