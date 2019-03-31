# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :avatar_id,              unsigned: true
      t.string  :username
      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :avatar_id
  end
end
