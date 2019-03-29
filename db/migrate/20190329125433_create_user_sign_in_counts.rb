class CreateUserSignInCounts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_sign_in_counts do |t|
      t.belongs_to :user
      t.timestamps
    end
  end
end
