class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :team, foreign_key: true
      t.integer :role
      t.datetime :invited_at
      t.datetime :accepted_at
      t.string :token

      t.timestamps
    end
  end
end
